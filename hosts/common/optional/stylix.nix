{ inputs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
    ../../../shared/stylix.nix
  ];

  stylix.homeManagerIntegration.autoImport = false;
}
