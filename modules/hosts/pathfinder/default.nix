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
      systemd-boot
      pipewire
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
        cli
        nvim
        desktop
        hyprland
        foot
        pinentry-gnome3
        calibre
        zathura
        firefox
        discord
      ];

      monitors = [
        {
          name = "eDP-1";
          width = 1920;
          height = 1080;
          workspace = "1";
          primary = true;
        }
      ];
    };

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
  };
}
