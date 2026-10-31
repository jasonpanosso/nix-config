{
  lib,
  config,
  inputs,
  ...
}:

let
  inherit (lib) mkOption types;

  mkHost =
    name: host:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        host.module
        {
          networking.hostName = name;
          nixpkgs.hostPlatform = host.system;
        }
      ]
      ++ map (user: {
        imports = [ config.users.${user}.nixos ];
        home-manager.users.${user}.imports = [ config.users.${user}.home ];
      }) host.users;
    };
in
{
  options.hosts = mkOption {
    description = "NixOS machines. Each becomes a nixosConfiguration and a check.";
    type = types.lazyAttrsOf (
      types.submodule {
        options = {
          system = mkOption {
            type = types.str;
            default = "x86_64-linux";
          };
          users = mkOption {
            type = types.listOf types.str;
            default = [ ];
          };
          sshPublicKey = mkOption {
            type = types.singleLineStr;
            description = "The host's ed25519 key, trusted by every other host.";
          };
          module = mkOption {
            type = types.deferredModule;
            default = { };
          };
        };
      }
    );
  };

  config = {
    flake.nixosConfigurations = lib.mapAttrs mkHost config.hosts;

    # `nix flake check` builds every host for its platform; homes are built as part of them
    perSystem =
      { system, ... }:
      {
        checks = lib.mapAttrs' (
          name: _:
          lib.nameValuePair "nixos-${name}"
            config.flake.nixosConfigurations.${name}.config.system.build.toplevel
        ) (lib.filterAttrs (_: host: host.system == system) config.hosts);
      };
  };
}
