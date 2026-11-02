{
  homeManager.profiles.base =
    { lib, ... }:
    {
      options.clipboard = {
        copy = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Command that reads stdin and puts it on the system clipboard.";
        };

        paste = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Command that writes the system clipboard to stdout.";
        };
      };
    };
}
