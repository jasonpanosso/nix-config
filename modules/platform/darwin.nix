{
  homeManager.modules.darwin =
    { pkgs, ... }:
    {
      clipboard = {
        copy = "pbcopy";
        paste = "pbpaste";
      };

      services.gpg-agent.pinentry.package = pkgs.pinentry_mac;
      home.packages = [ pkgs.pinentry_mac ];
    };
}
