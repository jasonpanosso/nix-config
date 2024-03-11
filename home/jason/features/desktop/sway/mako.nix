{ config, ... }:

let
  colors = config.colorscheme.palette;
in
{
  services.mako = {
    enable = true;
    iconPath = "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark";
    font = "${config.fontProfiles.regular.family} 14";
    padding = "10,20";
    anchor = "bottom-right";
    width = 400;
    height = 150;
    borderSize = 2;
    defaultTimeout = 0;
    backgroundColor = "#${colors.base00}dd";
    textColor = "#${colors.base0A}dd";
    borderColor = "#${colors.base03}dd";
    layer = "overlay";
  };
}
