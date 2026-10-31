{
  flake.modules.homeManager.shell = {
    programs.btop = {
      enable = true;
    };
  };
}
