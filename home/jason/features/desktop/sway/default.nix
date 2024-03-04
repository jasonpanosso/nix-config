{ pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
    };
  };

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
}
