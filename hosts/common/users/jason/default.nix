{ pkgs, config, ... }:
let ifGroupExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = true;
  users.users.jason = {
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

    openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/jason/ssh.pub) ];
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.jason = import ../../../../home/jason/${config.networking.hostName}.nix;

  security.pam.services = { swaylock = { }; };
}
