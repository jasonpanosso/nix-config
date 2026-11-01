{
  homeManager.profiles.desktop =
    { pkgs, ... }:

    {
      home.packages = with pkgs; [ playerctl ];

      services.playerctld = {
        enable = true;
      };
    };
}
