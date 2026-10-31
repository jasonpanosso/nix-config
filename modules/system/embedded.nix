{
  flake.modules.nixos.embedded =
    { pkgs, ... }:

    {
      services.udev.packages = with pkgs; [
        openocd
        stlink
      ];
    };
}
