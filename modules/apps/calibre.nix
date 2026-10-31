{
  flake.modules.homeManager.calibre =
    { pkgs, ... }:

    {
      home.packages = with pkgs; [ calibre ];
    };
}
