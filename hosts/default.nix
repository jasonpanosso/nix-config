{ system, overlays, pkgs, lib }:

{
  xps = pkgs.nixosSystem {
    inherit system lib;

    modules = [
      ./common.nix
      ./workstations/xps.nix
    ];
  };
}
