{ inputs, config, ... }:

let
  # one nixpkgs for everything: NixOS hosts, and the per-system pkgs behind
  # devShells, packages and standalone homes
  overlays = builtins.attrValues config.flake.overlays;
  nixpkgsConfig = {
    allowUnfree = true;
  };
in
{
  flake.overlays.rust-overlay = inputs.rust-overlay.overlays.default;

  nixos.modules.base = {
    nixpkgs = {
      inherit overlays;
      config = nixpkgsConfig;
    };
  };

  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system overlays;
        config = nixpkgsConfig;
      };
    };
}
