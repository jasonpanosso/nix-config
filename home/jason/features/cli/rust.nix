{ pkgs, ... }:

{
  home.packages = [
    (pkgs.rust-bin.stable.latest.default.override {
      extensions = [ "rust-src" "rust-analyzer" ];
    })
  ];
}
