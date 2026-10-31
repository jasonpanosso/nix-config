{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.users = mkOption {
    description = "People with an account on some host. A host lists the ones it has.";
    type = types.lazyAttrsOf (
      types.submodule (
        { name, ... }:
        {
          options = {
            nixos = mkOption {
              type = types.deferredModule;
              default = { };
              apply = module: {
                _class = "nixos";
                key = "nixos/user-${name}";
                imports = [ module ];
              };
            };

            home = mkOption {
              type = types.deferredModule;
              default = { };
              apply = module: {
                _class = "homeManager";
                key = "homeManager/user-${name}";
                imports = [ module ];
              };
            };
          };
        }
      )
    );
  };
}
