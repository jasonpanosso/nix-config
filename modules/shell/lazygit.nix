{
  homeManager.modules.base = {
    programs.lazygit = {
      enable = true;
      settings = {
        overrideGpg = false;
      };
    };
  };
}
