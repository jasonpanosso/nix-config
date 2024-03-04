{ pkgs, ... }:

{
  imports = [
    ./swaylock.nix
  ];
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.kitty}/bin/kitty";
    };
  };

  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.sway.default = [ "wlr" "gtk" ];
  };
}
