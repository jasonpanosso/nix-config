{ pkgs, ... }:

# helper script for getting a lang specific devshell with direnv setup
let
  nixenv = pkgs.writeShellScriptBin "nixenv" ''
    set -euo pipefail
    : "''${NH_FLAKE:?NH_FLAKE is not set}"
    shell="''${1:?usage: nixenv <rust|go> [channel]}"

    case "$shell" in
      rust) watch='rust-toolchain rust-toolchain.toml' ;;
      go)   watch='go.mod' ;;
      *)    watch="" ;;
    esac

    {
      [ -n "''${2:-}" ] && echo "export RUST_CHANNEL=$2"
      [ -n "$watch" ] && echo "watch_file $watch"
      echo "use flake \"\$NH_FLAKE#$shell\" --impure"
    } > .envrc

    if gitdir=$(git rev-parse --git-dir 2>/dev/null); then
      mkdir -p "$gitdir/info"
      grep -qxF ".envrc" "$gitdir/info/exclude" 2>/dev/null \
        || echo ".envrc" >> "$gitdir/info/exclude"
    fi

    direnv allow
  '';
in
{
  home.packages = [ nixenv ];
}
