{ system, pkgs, lib, inputs, commonConfig }:

{
  xps = import ./xps { inherit system pkgs lib inputs commonConfig; };
}
