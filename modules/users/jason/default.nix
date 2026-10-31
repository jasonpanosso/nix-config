{
  users.jason.nixos =
    { pkgs, config, ... }:
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
          ];

          hashedPasswordFile = config.sops.secrets.jason-password.path;
          openssh.authorizedKeys.keys = [ (builtins.readFile ./ssh.pub) ];
        };
      };

      sops.secrets.jason-password.neededForUsers = true;
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
