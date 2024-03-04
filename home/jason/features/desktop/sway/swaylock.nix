{ ... }:

{
  programs.swaylock = {
    enable = true;
    settings = {
      effect-blur = "20x3";
      fade-in = 0.1;

      font-size = 17;
      line-uses-inside = true;
      disable-caps-lock-text = true;
      indicator-caps-lock = true;
      indicator-radius = 40;
      indicator-idle-visible = true;
      indicator-y-position = 1000;
    };
  };
}
