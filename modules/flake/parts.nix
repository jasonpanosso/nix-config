{ inputs, ... }:

{
  imports = [ inputs.flake-parts.flakeModules.modules ];

  systems = [
    "aarch64-linux"
    "x86_64-linux"
  ];
}
