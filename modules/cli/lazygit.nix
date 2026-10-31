{
  flake.modules.homeManager.cli = {
    programs.lazygit = {
      enable = true;
      settings = {
        overrideGpg = false;
      };
    };
  };
}
