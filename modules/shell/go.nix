{
  homeManager.profiles.base =
    { pkgs, ... }:

    {
      home.packages = [ pkgs.go ];
    };
}
