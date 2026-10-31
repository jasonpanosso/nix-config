{
  networking.hostName = "wsl";
  home-manager.users.jason = {
    imports = [
      ./git-exe.nix
      ./clipboard.nix
    ];

    # no desktop on wsl
    dconf.enable = false;
  };
}
