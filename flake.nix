{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = { self, nixpkgs, nixos-wsl, ... } @ inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        overlays = builtins.attrValues outputs.overlays;
      });
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    in
    {
      overlays = import ./overlays { inherit inputs; };
      homeModules = import ./modules/home-manager;
      templates = import ./templates;
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./shells { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixfmt-tree);

      # `nix flake check` builds every host for its platform
      checks = forEachSystem (pkgs:
        lib.mapAttrs (_: host: host.config.system.build.toplevel)
          (lib.filterAttrs (_: host: host.pkgs.stdenv.hostPlatform.system == pkgs.stdenv.hostPlatform.system)
            self.nixosConfigurations));

      nixosConfigurations = {
        # Laptop - XPS 13
        pathfinder = lib.nixosSystem {
          modules = [ ./hosts/pathfinder ];
          specialArgs = {
            inherit inputs outputs;
          };
        };

        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/wsl
            nixos-wsl.nixosModules.default
            {
              system.stateVersion = "26.05";
              wsl.enable = true;
              wsl.defaultUser = "jason";
            }
          ];

          specialArgs = {
            inherit inputs outputs;
          };
        };
      };
    };
}
