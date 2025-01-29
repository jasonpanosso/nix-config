{ config, ... }:

{
  services.mako = {
    enable = true;
    # iconPath = "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark";
    padding = "10,20";
    anchor = "bottom-right";
    width = 400;
    height = 150;
    borderSize = 2;
    defaultTimeout = 0;
    layer = "overlay";
  };
}
