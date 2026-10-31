{ inputs, config, ... }:

let
  overlays = builtins.attrValues config.flake.overlays;
  nixpkgsConfig = {
    allowUnfree = true;
  };
in
{
  flake.modules.nixos.base = {
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
