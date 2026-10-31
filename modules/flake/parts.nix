{ inputs, ... }:

{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];

  systems = [
    "aarch64-linux"
    "x86_64-linux"
  ];
}
