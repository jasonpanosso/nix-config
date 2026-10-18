{ pkgs }:

let
  inherit (pkgs) lib;
  extras = [ "rust-src" "rust-analyzer" ];

  pwd = builtins.getEnv "PWD"; # "" when pure

  # rustup checks rust-toolchain before rust-toolchain.toml
  candidates = map (f: "${pwd}/${f}") [ "rust-toolchain" "rust-toolchain.toml" ];
  found = lib.optionals (pwd != "") (builtins.filter builtins.pathExists candidates);

  fromFile = path:
    let
      content = builtins.readFile (/. + path);
      spec =
        if lib.hasInfix "[toolchain]" content
        then (builtins.fromTOML content).toolchain
        else { channel = lib.trim content; };
    in
    pkgs.rust-bin.fromRustupToolchain (spec // {
      components = (spec.components or [ ]) ++ extras;
    });

  toolchain =
    if found != [ ]
    then fromFile (builtins.head found)
    else pkgs.rust-bin.stable.latest.default.override { extensions = extras; };
in
pkgs.mkShell {
  name = "rust";
  packages = [ toolchain pkgs.pkg-config pkgs.openssl ];
}
