{ config, ... }:

{
  # a machine with a graphical session hands its homes the desktop too
  nixos.profiles.desktop = {
    home-manager.sharedModules = [ config.homeManager.profiles.desktop ];

    # home-manager's xdg.portal needs these linked when homes install into the system profile
    environment.pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
  };
}
