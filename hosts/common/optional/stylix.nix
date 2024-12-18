{ inputs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
    ../../../shared/stylix.nix
  ];
}
