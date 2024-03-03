{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/3476ed2b-d7b0-4e56-ba7d-6b5ea2b48fb8";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-0318fb83-5906-45f8-9709-53a7a700413c".device =
    "/dev/disk/by-uuid/0318fb83-5906-45f8-9709-53a7a700413c";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/AA44-9082";
    fsType =
      "vfat";
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/99a515d1-d916-45a2-bef9-a9715b300374"; }];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
