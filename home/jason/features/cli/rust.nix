{ pkgs, ... }:

let
  rustenv = pkgs.writeShellScriptBin "rustenv" ''
    set -euo pipefail

    {
      [ -n "''${1:-}" ] && echo "export RUST_CHANNEL=$1"
      echo 'watch_file rust-toolchain rust-toolchain.toml'
      echo 'use flake "$NH_FLAKE#rust" --impure'
    } > .envrc

    direnv allow
  '';
in
{
  home.packages = [
    (pkgs.rust-bin.stable.latest.default.override {
      extensions = [ "rust-src" "rust-analyzer" ];
    })
    rustenv
  ];
}
