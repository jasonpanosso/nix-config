{
  users.jason.home =
    { pkgs, config, ... }:

    {
      # the pinentry depends on the environment, so whoever composes this home picks it
      assertions = [
        {
          assertion = config.services.gpg-agent.pinentry.package != null;
          message = "gpg: no pinentry chosen; compose this home from a profile that picks one (homeManager.profiles.linux) or set services.gpg-agent.pinentry.package";
        }
      ];

      # learn the plugged in yubikey (new machine or swapped yubikey), then unlock it
      home.shellAliases.gpg-unlock = "gpg-connect-agent 'scd serialno' 'learn --force' updatestartuptty /bye >/dev/null && echo | gpg --clearsign -u jason@jasonpanosso.com >/dev/null && echo unlocked";

      services.gpg-agent = {
        enable = true;
        enableExtraSocket = true;
        defaultCacheTtl = 3600;
        maxCacheTtl = 7200;
      };

      programs =
        let
          fixGpg = /* bash */ ''
            gpgconf --launch gpg-agent
          '';
        in
        {
          # Start gpg-agent if it's not running or tunneled in
          # SSH does not start it automatically, so this is needed to avoid having to use a gpg command at startup
          # https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
          bash.profileExtra = fixGpg;
          zsh.loginExtra = fixGpg;

          gpg = {
            enable = true;
            settings = {
              trust-model = "tofu+pgp";
            };
            # go through pcscd instead of claiming the yubikey, so age-plugin-yubikey can still reach it
            scdaemonSettings.disable-ccid = true;
            publicKeys = [
              {
                source = ./pgp.asc;
                trust = 5;
              }
            ];
          };
        };

      systemd.user.services = {
        # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
        # So that SSH config does not have to know the UID
        link-gnupg-sockets = {
          Unit = {
            Description = "link gnupg sockets from /run to /home";
          };
          Service = {
            Type = "oneshot";
            ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
            ExecStop = "${pkgs.coreutils}/bin/rm ${config.home.homeDirectory}/.gnupg-sockets";
            RemainAfterExit = true;
          };
          Install.WantedBy = [ "default.target" ];
        };
      };
    };
}
