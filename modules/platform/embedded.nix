{
  nixos.profiles.base =
    { pkgs, ... }:

    {
      services.udev.packages = with pkgs; [
        openocd
        stlink
      ];

      services.udev.extraRules = ''
        # SEGGER J-Link (nRF52840 DK onboard debugger)
        SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", MODE="0660", GROUP="users"
        # CMSIS-DAP / DAPLink probes
        SUBSYSTEM=="usb", ATTRS{idVendor}=="0d28", MODE="0660", GROUP="users"
      '';
    };
}
