{ pkgs, ... }:

{
  imports = [
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];

  wayland.windowManager.sway =
    let modifier = "Mod4"; in
    {
      enable = true;
      config = {
        modifier = modifier;
        terminal = "${pkgs.kitty}/bin/kitty";
        window = {
          border = 0;
          titlebar = false;
          hideEdgeBorders = "smart";
        };
        bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];
        focus = {
          followMouse = false;
        };
        gaps = {
          smartBorders = "on";
          smartGaps = false;
        };
        defaultWorkspace = "workspace number 4";

        keybindings = {
          "${modifier}+Space" = "exec ${pkgs.wofi}/bin/wofi --show=drun";
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
