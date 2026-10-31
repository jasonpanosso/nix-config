{ lib, config, ... }:

{
  # `nix flake check` builds every host for its platform
  perSystem =
    { pkgs, ... }:
    {
      checks = lib.mapAttrs (_: host: host.config.system.build.toplevel) (
        lib.filterAttrs (
          _: host: host.pkgs.stdenv.hostPlatform.system == pkgs.stdenv.hostPlatform.system
        ) config.flake.nixosConfigurations
      );
    };
}
