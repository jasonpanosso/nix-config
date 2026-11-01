{
  nixos.profiles.metal = {
    hardware.enableRedistributableFirmware = true;

    boot.initrd.systemd.enable = true;
  };
}
