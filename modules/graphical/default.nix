{
  # a home with a display: native session, or WSLg
  homeManager.profiles.graphical =
    { pkgs, ... }:
    {
      services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;

      home.packages = with pkgs; [
        pinentry-gnome3
        gcr_4 # system prompter pinentry-gnome3 talks to outside GNOME
      ];
    };
}
