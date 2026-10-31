# Transitional: wraps the pre-dendritic hosts until each piece moves into modules/
{ inputs, config, ... }:

let
  inherit (config.flake.modules) nixos homeManager;

  specialArgs = { inherit inputs; };

  legacy = {
    home-manager.extraSpecialArgs = specialArgs;
    home-manager.users.jason.imports = [
      homeManager.base
      homeManager.jason
    ];
  };
in
{
  flake.nixosConfigurations = {
    # Laptop - XPS 13
    pathfinder = inputs.nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules = [
        nixos.base
        nixos.jason
        legacy
        ../../hosts/pathfinder
      ];
    };

    wsl = inputs.nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      system = "x86_64-linux";
      modules = [
        nixos.base
        nixos.jason
        nixos.stylix
        legacy
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
