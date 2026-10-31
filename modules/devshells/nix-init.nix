# Shell for bootstrapping flake-enabled nix and other tooling
{
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = config.devShells.nix-init;
      devShells.nix-init = pkgs.mkShell {
        NIX_CONFIG = "extra-experimental-features = nix-command flakes";
        nativeBuildInputs = with pkgs; [
          nix
          home-manager
          git

          sops
          ssh-to-age
          gnupg
          age
        ];
      };
    };
}
