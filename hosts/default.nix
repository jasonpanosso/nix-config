{ system, pkgs, lib, inputs }:

let
  commonConfig = import ./common.nix { inherit pkgs lib inputs; };

  importConfigs = typePath: import typePath {
    inherit system pkgs lib inputs commonConfig;
  };
in
importConfigs ./workstations
  //
importConfigs ./servers;
