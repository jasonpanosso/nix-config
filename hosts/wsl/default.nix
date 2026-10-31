{
  imports = [
    ../common/optional/docker.nix
  ];

  networking.hostName = "wsl";
  home-manager.users.jason = {
    imports = [
      ../../home/jason/features/cli
      ../../home/jason/features/nvim
      ./git-exe.nix
      ./clipboard.nix
    ];

    # no desktop on wsl
    dconf.enable = false;
  };
}
