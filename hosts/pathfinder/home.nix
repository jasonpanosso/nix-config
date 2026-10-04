{
  imports = [
    ../../home/jason/common
    ../../home/jason/features/desktop/hyprland
    ../../home/jason/features/desktop/optional/firefox.nix
    ../../home/jason/features/desktop/optional/discord.nix
  ];

  monitors = [{
    name = "eDP-1";
    width = 1920;
    height = 1080;
    workspace = "1";
    primary = true;
  }];
}
