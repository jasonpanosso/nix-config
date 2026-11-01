# one FIDO2 ssh key per yubikey, used for ssh logins and git signing
# pub keys in ./yubikeys/<serial>.pub, yubikey handles stored as secret (ssh-yk-<serial>)
{ lib, ... }:

let
  dir = ./yubikeys;
  serials = lib.pipe (lib.optionalAttrs (builtins.pathExists dir) (builtins.readDir dir)) [
    builtins.attrNames
    (builtins.filter (lib.hasSuffix ".pub"))
    (map (lib.removeSuffix ".pub"))
  ];
  pub = serial: dir + "/${serial}.pub";
  secret = serial: "ssh-yk-${serial}";
in
{
  users.jason.nixos = {
    sops.secrets = lib.genAttrs (map secret serials) (_: {
      owner = "jason";
    });

    users.users.jason.openssh.authorizedKeys.keys = map (s: builtins.readFile (pub s)) serials;
  };

  users.jason.home =
    {
      pkgs,
      config,
      osConfig,
      ...
    }:
    let
      handle = serial: osConfig.sops.secrets.${secret serial}.path;

      allowedSigners = pkgs.writeText "allowed_signers" (
        lib.concatMapStrings (
          s: ''${config.programs.git.settings.user.email} namespaces="git" ${builtins.readFile (pub s)}''
        ) serials
      );

      # ssh-copy-id only appends when the name ends in .pub
      authorizedKeys = pkgs.writeText "yubikeys.pub" (
        lib.concatMapStrings (s: builtins.readFile (pub s)) serials
      );

      # sign with currently plugged in yubikeys ssh key
      gitSigningKey = pkgs.writeShellApplication {
        name = "git-signing-key";
        runtimeInputs = [
          pkgs.yubikey-manager
          pkgs.openssh
        ];
        text = ''
          handle="" pub=""
          while read -r serial; do
            case "$serial" in
              ${lib.concatMapStringsSep "\n    " (
                s: "${s}) handle=${handle s} pub=${pub s}; break ;;"
              ) serials}
            esac
          done < <(ykman list --serials)
          [ -n "$handle" ] || { echo "git-signing-key: no known yubikey plugged in" >&2; exit 1; }

          blob=$(cut -d' ' -f1,2 "$pub")
          ssh-add -L 2>/dev/null | grep -qF "$blob" || ssh-add "$handle" >&2
          echo "key::$blob"
        '';
      };
    in
    lib.mkIf (serials != [ ]) {
      home.packages = [
        (pkgs.writeShellApplication {
          name = "ssh-copy-yubikeys";
          runtimeInputs = [ pkgs.openssh ];
          text = ''exec ssh-copy-id -f -i ${authorizedKeys} "$@"'';
        })

        (pkgs.writeShellApplication {
          name = "gh-add-yubikeys";
          runtimeInputs = [
            pkgs.github-cli
            pkgs.gawk
          ];
          text = ''
            # tab separated: title, key, added, id, type
            existing=$(gh ssh-key list)
            while read -r serial pub; do
              blob=$(cut -d' ' -f2 "$pub")
              if awk -F'\t' -v b="$blob" '$5 == "signing" && index($2, b) { f = 1 } END { exit !f }' <<<"$existing"; then
                echo "yubikey $serial: already on github"
              else
                gh ssh-key add "$pub" --type signing --title "yubikey $serial"
              fi
            done <<EOF
            ${lib.concatMapStringsSep "\n" (s: "${s} ${pub s}") serials}
            EOF
          '';
        })
      ];

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings."*" = {
          # an absent yubikey's handle fails and ssh moves on to the next
          IdentityFile = map handle serials;
          ControlMaster = "auto";
          ControlPath = "~/.ssh/control-%C";
          ControlPersist = "10m";
        };
      };

      programs.git.settings = {
        gpg.format = "ssh";
        gpg.ssh.defaultKeyCommand = lib.getExe gitSigningKey;
        gpg.ssh.allowedSignersFile = "${allowedSigners}";
      };
    };
}
