{
  users.jason.nixos =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      ifGroupExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
    in
    {
      # enabled here to allow users to login with zsh, more configuration in hm
      programs.zsh.enable = true;

      users = {
        mutableUsers = false;
        users.jason = {
          isNormalUser = true;
          shell = pkgs.zsh;
          extraGroups = [
            "wheel"
            "video"
            "audio"
          ]
          ++ ifGroupExists [
            "network"
            "networkmanager"
            "i2c"
            "docker"
            "git"
            "libvirtd"
            "plugdev"
          ];

          hashedPasswordFile = config.sops.secrets.jason-password.path;
          openssh.authorizedKeys.keys = [ (builtins.readFile ./ssh.pub) ];
        };
      };

      sops.secrets.jason-password.neededForUsers = true;

      # yubikey for sudo; generate with:
      #   pamu2fcfg -u jason -o pam://nix-config -i pam://nix-config > modules/users/jason/u2f_keys
      environment.etc."u2f-mappings" = lib.mkIf (builtins.pathExists ./u2f_keys) {
        text = builtins.readFile ./u2f_keys;
      };
    };

  users.jason.home =
    { lib, config, ... }:
    {
      home = {
        username = lib.mkDefault "jason";
        homeDirectory = lib.mkDefault "/home/${config.home.username}";
        file.".ideavimrc".source = ./ideavimrc;
      };
    };
}
