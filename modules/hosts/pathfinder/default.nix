{ inputs, config, ... }:

let
  inherit (config.flake.modules) nixos homeManager;
in
{
  # Laptop - XPS 13
  flake.nixosConfigurations.pathfinder = inputs.nixpkgs.lib.nixosSystem {
    modules = with nixos; [
      base
      jason
      dconf
      docker
      boot
      audio
      hyprland
      embedded
      pathfinder
    ];
  };

  flake.modules.nixos.pathfinder = {
    imports = [
      ./_hardware.nix
      inputs.hardware.nixosModules.dell-xps-13-9360
      inputs.xremap-flake.nixosModules.default
    ];

    home-manager.users.jason = {
      imports = with homeManager; [
        base
        jason
        shell
        nvim
        desktop
        audio
        hyprland
        foot
        pinentry-gnome3
        calibre
        zathura
        firefox
        discord
      ];

      desktop.monitors = [
        {
          name = "eDP-1";
          width = 1920;
          height = 1080;
          workspaces = [ "1" ];
        }
      ];
    };

    swapDevices = [ { label = "swap"; } ];

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
  };
}
