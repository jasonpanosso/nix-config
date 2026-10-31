# Transitional: wraps the pre-dendritic hosts until each piece moves into modules/
{ inputs, config, ... }:

let
  inherit (config.flake.modules) nixos homeManager;

  specialArgs = { inherit inputs; };

  home = modules: {
    home-manager.extraSpecialArgs = specialArgs;
    home-manager.users.jason.imports = modules;
  };
in
{
  flake.nixosConfigurations = {
    # Laptop - XPS 13
    pathfinder = inputs.nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules = with nixos; [
        base
        jason
        dconf
        docker
        systemd-boot
        pipewire
        embedded
        (home (
          with homeManager;
          [
            base
            jason
            cli
            nvim
            desktop
            hyprland
            calibre
            zathura
            firefox
            discord
          ]
        ))
        ../../hosts/pathfinder
      ];
    };

    wsl = inputs.nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      system = "x86_64-linux";
      modules = with nixos; [
        base
        jason
        stylix
        docker
        (home (
          with homeManager;
          [
            base
            jason
            cli
            nvim
          ]
        ))
        ../../hosts/wsl
        inputs.nixos-wsl.nixosModules.default
        {
          system.stateVersion = "26.05";
          wsl.enable = true;
          wsl.defaultUser = "jason";
        }
      ];
    };
  };
}
