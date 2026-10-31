# Laptop - XPS 13
{ inputs, config, ... }:

{
  hosts.pathfinder = {
    users = [ "jason" ];
    sshPublicKey = builtins.readFile ./ssh_host_ed25519_key.pub;

    module = {
      imports = [
        config.nixos.modules.desktop
        ./_hardware.nix
        inputs.hardware.nixosModules.dell-xps-13-9360
        inputs.xremap-flake.nixosModules.default
      ];

      swapDevices = [ { label = "swap"; } ];

      networking.networkmanager.enable = true;

      powerManagement.powertop.enable = true;

      # Lid settings
      services.logind.settings.Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "lock";
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

      home-manager.sharedModules = [
        {
          desktop.monitors = [
            {
              name = "eDP-1";
              width = 1920;
              height = 1080;
              workspaces = [ "1" ];
            }
          ];
        }
      ];
    };
  };
}
