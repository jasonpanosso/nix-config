{
  imports = [
    ../common/global
    ../common/users/jason
    ../common/optional/docker.nix
    ../common/optional/stylix.nix
  ];

  networking.hostName = "wsl";
  home-manager.users.jason = {
    imports = [ ../../home/jason/common ];

    # no desktop on wsl
    dconf.enable = false;
  };
}
