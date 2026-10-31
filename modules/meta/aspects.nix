# The lower-level modules this repo composes hosts and homes from.
# Each is a declared option, so a misspelt name fails at eval, and each
# carries a `key`, so importing one twice is a no-op.
{ lib, config, ... }:

let
  aspect =
    class: name: includes:
    lib.mkOption {
      type = lib.types.deferredModuleWith { staticModules = includes; };
      default = { };
      apply = module: {
        _class = class;
        key = "${class}/${name}";
        imports = [ module ];
      };
    };

  nixos = config.nixos.modules;
  home = config.homeManager.modules;
in
{
  options.nixos.modules = {
    base = aspect "nixos" "base" [ ];
    desktop = aspect "nixos" "desktop" [ nixos.base ];
  };

  options.homeManager.modules = {
    base = aspect "homeManager" "base" [ ];
    linux = aspect "homeManager" "linux" [ home.base ];
    darwin = aspect "homeManager" "darwin" [ home.base ];
    desktop = aspect "homeManager" "desktop" [ home.linux ];
    wsl = aspect "homeManager" "wsl" [ home.linux ];
  };
}
