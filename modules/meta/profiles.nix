{ lib, config, ... }:

let
  profile =
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

  nixos = config.nixos.profiles;
  home = config.homeManager.profiles;
in
{
  options.nixos.profiles = {
    base = profile "nixos" "base" [ ];
    metal = profile "nixos" "metal" [ nixos.base ];
    desktop = profile "nixos" "desktop" [ nixos.base ];
  };

  options.homeManager.profiles = {
    base = profile "homeManager" "base" [ ];
    linux = profile "homeManager" "linux" [ home.base ];
    darwin = profile "homeManager" "darwin" [ home.base ];
    terminal = profile "homeManager" "terminal" [ home.linux ];
    apps = profile "homeManager" "apps" [ home.terminal ];
    desktop = profile "homeManager" "desktop" [ home.apps ];
    wsl = profile "homeManager" "wsl" [ home.linux ];
  };
}
