{
  flake.modules.nixos.jason =
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
          packages = [ pkgs.home-manager ];
        };
      };

      sops.secrets.jason-password = {
        sopsFile = ../../../hosts/common/secrets.enc.yaml;
        neededForUsers = true;
      };
    };

  flake.modules.homeManager.jason =
    { lib, config, ... }:
    {
      home = {
        username = lib.mkDefault "jason";
        homeDirectory = lib.mkDefault "/home/${config.home.username}";
        file.".ideavimrc".source = ./ideavimrc;
      };
    };
}
