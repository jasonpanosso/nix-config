{ pkgs }:

let
  files = builtins.attrNames (pkgs.lib.filterAttrs
    (n: t: t == "regular" && n != "default.nix" && pkgs.lib.hasSuffix ".nix" n)
    (builtins.readDir ./.));
  shells = builtins.listToAttrs (map
    (f: {
      name = pkgs.lib.removeSuffix ".nix" f;
      value = import (./. + "/${f}") { inherit pkgs; };
    })
    files);
in
shells // { default = shells.nix-init; }
