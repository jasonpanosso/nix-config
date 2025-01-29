{ pkgs, ... }:

{
  programs.swaylock = {
    package = pkgs.swaylock-effects;
    enable = true;

    settings = {
      daemonize = true;
      screenshots = true;
      clock = true;
      show-failed-attempts = true;

      effect-blur = "8x3";
      effect-scale = 2;
      effect-vignette = "0.5:0.5";
      font-size = 25;
      datestr = "%m-%d";
      fade-in = 0.1;
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 12;
    };
  };
}
