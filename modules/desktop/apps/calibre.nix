{
  homeManager.profiles.desktop =
    { pkgs, ... }:

    {
      home.packages = with pkgs; [ calibre ];
    };
}
