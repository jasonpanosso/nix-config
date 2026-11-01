{
  homeManager.profiles.base =
    { lib, ... }:
    {
      options.clipboard = {
        copy = lib.mkOption {
          type = lib.types.str;
          description = "Command that reads stdin and puts it on the system clipboard.";
        };

        paste = lib.mkOption {
          type = lib.types.str;
          description = "Command that writes the system clipboard to stdout.";
        };
      };
    };
}
