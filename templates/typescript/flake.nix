{
  description = "typescript devshell flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      });
    in
    {
      devShells = forEachSupportedSystem
        ({ pkgs }: {
          default = pkgs.mkShell {
            packages = [
              pkgs.nodePackages_latest.npm
              pkgs.nodePackages_latest.typescript
              pkgs.nodePackages_latest.typescript-language-server
              pkgs.nodePackages_latest.eslint
              pkgs.nodePackages_latest.prettier
            ];
          };
        });
    };
}
