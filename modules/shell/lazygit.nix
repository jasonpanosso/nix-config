{
  flake.modules.homeManager.shell = {
    programs.lazygit = {
      enable = true;
      settings = {
        overrideGpg = false;
      };
    };
  };
}
