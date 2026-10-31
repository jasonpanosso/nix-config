{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.dell-xps-13-9360
    inputs.xremap-flake.nixosModules.default

    ../common/optional/dconf.nix
    ../common/optional/docker.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/pipewire.nix
    ../common/optional/embedded.nix
  ];

  home-manager.users.jason = ./home.nix;
  swapDevices = [ { label = "swap"; } ];

  networking = {
    hostName = "pathfinder";
    networkmanager.enable = true;
  };

  powerManagement.powertop.enable = true;

  # hm installs xdg portals into the user profile (useUserPackages)
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  hardware.graphics.enable = true;

  system.stateVersion = "23.11";

  services.xremap = {
    enable = true;
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
