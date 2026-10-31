{ lib, pkgs, ... }:

{
  options.clipboard = {
    copy = lib.mkOption {
      type = lib.types.str;
      default = "${pkgs.wl-clipboard}/bin/wl-copy";
      description = "Command that reads stdin and puts it on the system clipboard.";
    };

    paste = lib.mkOption {
      type = lib.types.str;
      default = "${pkgs.wl-clipboard}/bin/wl-paste --no-newline";
      description = "Command that writes the system clipboard to stdout.";
    };
  };
}
