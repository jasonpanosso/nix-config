{
  # must configure monitors for "desktop" features
  homeManager.profiles.desktop =
    { lib, ... }:
    let
      inherit (lib) mkOption types;
    in
    {
      options.desktop.monitors = mkOption {
        description = "Displays attached to this machine.";
        type = types.nonEmptyListOf (
          types.submodule {
            options = {
              name = mkOption {
                type = types.str;
                example = "eDP-1";
                description = "Connector name.";
              };
              description = mkOption {
                type = types.nullOr types.str;
                default = null;
                example = "ASUSTek COMPUTER INC VG259QM M1LMQS046469";
                description = "Make, model and serial; matched instead of `name` when set, so the display is found on any port.";
              };
              width = mkOption {
                type = types.int;
                example = 1920;
              };
              height = mkOption {
                type = types.int;
                example = 1080;
              };
              refreshRate = mkOption {
                type = types.int;
                default = 60;
              };
              x = mkOption {
                type = types.int;
                default = 0;
              };
              y = mkOption {
                type = types.int;
                default = 0;
              };
              scale = mkOption {
                type = types.number;
                default = 1;
              };
              workspaces = mkOption {
                type = types.listOf types.str;
                default = [ ];
                description = "Workspaces pinned to this display; the first is its default.";
              };
            };
          }
        );
      };
    };
}
