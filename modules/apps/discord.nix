{
  homeManager.profiles.apps =
    { pkgs, ... }:

    {
      home.packages = with pkgs; [ discord ];
    };
}
