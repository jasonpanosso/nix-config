{
  description = "typescript devshell flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nodePackages_latest.npm
            nodePackages_latest.typescript
            nodePackages_latest.typescript-language-server
            nodePackages_latest.eslint
            nodePackages_latest.prettier
          ];
        };
      }
    );
}
