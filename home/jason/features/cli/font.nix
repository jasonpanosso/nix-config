{ pkgs, ... }:

{
  fontProfiles = {
    enable = true;

    monospace = {
      family = "IosevkaTerm Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "IosevkaTerm" ]; };
    };
    regular = {
      family = "Iosevka";
      package = pkgs.iosevka;
    };
  };
}
