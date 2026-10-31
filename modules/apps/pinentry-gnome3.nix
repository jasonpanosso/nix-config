{
  flake.modules.homeManager.pinentry-gnome3 =
    { pkgs, ... }:
    {
      services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;

      home.packages = [
        pkgs.pinentry-gnome3
        pkgs.gcr_4 # system prompter pinentry-gnome3 talks to outside GNOME
      ];
    };
}
