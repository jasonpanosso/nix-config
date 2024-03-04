{ pkgs, ... }:

{
  imports = [
    ./swaylock.nix
  ];

  wayland.windowManager.sway =
    let modifier = "Mod4"; in
    {
      enable = true;
      config = {
        modifier = modifier;
        terminal = "${pkgs.kitty}/bin/kitty";
        window = {
          titlebar = false;
          hideEdgeBorders = "both";
        };
      };
    };

  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.sway.default = [ "wlr" "gtk" ];
  };
}
