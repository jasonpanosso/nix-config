{
  nixos.modules.desktop =
    { pkgs, ... }:

    {
      services.udev.packages = with pkgs; [
        openocd
        stlink
      ];
    };
}
