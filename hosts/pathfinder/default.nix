{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.dell-xps-13-9360
    inputs.xremap-flake.nixosModules.default

    ../common/global
    ../common/users/jason

    ../common/optional/dconf.nix
    ../common/optional/docker.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix
    ../common/optional/embedded.nix
  ];

  swapDevices = [{ label = "swap"; }];

  networking = {
    hostName = "pathfinder";
    networkmanager.enable = true;
  };

  powerManagement.powertop.enable = true;

  programs = {
    light.enable = true;
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  hardware.opengl.enable = true;

  system.stateVersion = "23.11";

  services.xremap = {
    withWlroots = true;
    userName = "jason";
    config = {
      modmap = [
        {
          name = "Global CapsLock to Ctrl";
          remap = {
            "CapsLock" = "CTRL_L";
          };
        }
      ];
    };
  };
}
