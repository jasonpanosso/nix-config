{ inputs, ... }:

let
  theme =
    { pkgs, ... }:
    {
      fonts.fontconfig.enable = true;

      stylix = {
        enable = true;
        autoEnable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";

        fonts = {
          monospace = {
            name = "IosevkaTerm Nerd Font";
            package = pkgs.nerd-fonts.iosevka-term;
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
            package = pkgs.noto-fonts-color-emoji;
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
    };

  cursor =
    { pkgs, ... }:
    {
      stylix.cursor = {
        name = "Vanilla-DMZ";
        package = pkgs.vanilla-dmz;
        size = 20;
      };
    };
in
{
  flake.modules.nixos.base = {
    imports = [
      inputs.stylix.nixosModules.stylix
      theme
      cursor
    ];

    # each home imports stylix itself
    stylix.homeManagerIntegration.autoImport = false;
  };

  flake.modules.homeManager.base = {
    imports = [
      inputs.stylix.homeModules.stylix
      theme
    ];

    # stylix's overlays set nixpkgs.overlays, which useGlobalPkgs forbids
    stylix.overlays.enable = false;

    # rofi isn't used (wofi is), and stylix's rofi target sets a renamed option
    stylix.targets.rofi.enable = false;
  };

  flake.modules.homeManager.linux.imports = [ cursor ];
}
