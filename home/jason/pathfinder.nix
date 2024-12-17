{
  imports = [
    ./common
    ./features/desktop/common
    ./features/desktop/sway
    ./features/desktop/optional/firefox.nix
  ];

  monitors = [{
    name = "eDP-1";
    width = 1920;
    height = 1080;
    workspace = "1";
    primary = true;
  }];
}
