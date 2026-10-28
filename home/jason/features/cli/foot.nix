{ lib, pkgs, ... }:

{
  home.sessionVariables.TERMINAL = lib.getBin pkgs.foot;

  programs.foot = {
    enable = true;

    settings = {
      bell = {
        system = "no";
        urgent = "no";
        notify = "no";
        visual = "no";
      };

      cursor = {
        blink = "yes";
        blink-rate = "500";
        style = "block";
      };

      main = {
        # dpi-aware = "yes";
        term = "xterm-256color";
      };

      scrollback = {
        lines = 10000;
      };

      # dimmed text looking a bit weird with kanagawa
      colors-light.dim-blend-towards = "black";
      colors-dark.dim-blend-towards = "black";

      # shift+enter = newline
      text-bindings = {
        "\\x1b\\x0d" = "Shift+Return";
      };
    };
  };
}
