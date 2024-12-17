{ pkgs, config, ... }:

let
  ifGroupExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users = {
    mutableUsers = false;
    users.jason = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "video"
        "audio"
      ] ++ ifGroupExists [
        "network"
        "networkmanager"
        "sway"
        "wireshark"
        "i2c"
        "docker"
        "git"
        "libvirtd"
      ];

      hashedPasswordFile = config.sops.secrets.jason-password.path;
      openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/jason/ssh.pub) ];
      packages = [ pkgs.home-manager ];
    };
  };

  sops.secrets.jason-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager = {
    users.jason = import ../../../../home/jason/${config.networking.hostName}.nix;
    # backupFileExtension = "backup";
  };

  security.pam.services = { swaylock = { }; };
}
