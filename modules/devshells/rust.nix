{
  perSystem =
    { pkgs, ... }:
    let
      inherit (pkgs) lib;
      extras = [
        "rust-src"
        "rust-analyzer"
      ];

      pwd = builtins.getEnv "PWD"; # "" when pure

      # rustup checks rust-toolchain before rust-toolchain.toml
      candidates = map (f: "${pwd}/${f}") [
        "rust-toolchain"
        "rust-toolchain.toml"
      ];
      found = lib.optionals (pwd != "") (builtins.filter builtins.pathExists candidates);

      # set by `nixenv rust <channel>`; only used when there's no toolchain file
      channel = builtins.getEnv "RUST_CHANNEL"; # "" when pure or unset

      fromSpec =
        spec:
        pkgs.rust-bin.fromRustupToolchain (
          spec
          // {
            components = (spec.components or [ ]) ++ extras;
          }
        );

      fromFile =
        path:
        let
          content = builtins.readFile (/. + path);
        in
        fromSpec (
          if lib.hasInfix "[toolchain]" content then
            (builtins.fromTOML content).toolchain
          else
            { channel = lib.trim content; }
        );

      toolchain =
        if found != [ ] then
          fromFile (builtins.head found)
        else if channel != "" then
          fromSpec { inherit channel; }
        else
          pkgs.rust-bin.stable.latest.default.override { extensions = extras; };
    in
    {
      devShells.rust = pkgs.mkShell {
        name = "rust";
        packages = [
          toolchain
          pkgs.pkg-config
          pkgs.openssl
        ];
      };
    };
}
