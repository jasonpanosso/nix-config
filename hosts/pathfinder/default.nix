{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/jason

    ../common/optional/docker.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/greetd.nix

    inputs.hardware.nixosModules.dell-xps-13-9360
    inputs.xremap-flake.nixosModules.default
  ];

  networking = {
    hostName = "pathfinder";
    networkmanager.enable = true;
  };

  powerManagement.powertop.enable = true;

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
