{ ... }: {
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/jason

    ../common/optional/wireless.nix
    ../common/optional/docker.nix
    ../common/optional/systemd-boot.nix
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
}
