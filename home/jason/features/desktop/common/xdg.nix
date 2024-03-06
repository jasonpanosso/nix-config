{ config, ... }:

{
  xdg = {
    portal.enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
      };
    };
  };
}
