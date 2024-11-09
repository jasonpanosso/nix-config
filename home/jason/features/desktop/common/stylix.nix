{ pkgs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";

    fonts = {
      monospace = {
        name = "IosevkaTerm Nerd Font";
        package = pkgs.nerdfonts.override { fonts = [ "IosevkaTerm" ]; };
      };

      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };

      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = 17;
      };
    };


    image = pkgs.fetchurl {
      url = "https://i.imgur.com/ivh6aQ3.png";
      sha256 = "nw1JNlircbublRy/1MhfiQWuDy2r1w+taRkb38x4N6I=";
    };
  };

  home.packages = [
    (pkgs.nerdfonts.override {
      fonts = [
        "IosevkaTerm"
        "IosevkaTermSlab"
        "Iosevka"
      ];
    })
  ];
}
