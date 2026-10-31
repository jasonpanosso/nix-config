# Transitional: wraps the pre-dendritic tree until each piece moves into modules/
{ inputs, self, ... }:

let
  specialArgs = {
    inherit inputs;
    outputs = self;
  };
in
{
  flake = {
    homeModules = import ../../home/modules;

    nixosConfigurations = {
      # Laptop - XPS 13
      pathfinder = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [ ../../hosts/pathfinder ];
      };

      wsl = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
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
  };
}
