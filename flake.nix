{
  description = "Jason Panosso's system configurations";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      overlays = [
        (final: prev: {
          lib = prev.lib // { my = import ./lib { inherit (final) lib; }; };
        })
        inputs.neovim-nightly-overlay.overlay
      ];

      pkgs = import nixpkgs {
        inherit overlays system;
        config.allowUnfree = true;
      };

      inherit (pkgs) lib;
    in
    {
      nixosConfigurations = import ./hosts { inherit system pkgs lib inputs; };
    };
}
