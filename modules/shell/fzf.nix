{
  flake.modules.homeManager.shell = {
    programs.fzf = {
      enable = true;
      defaultOptions = [ "--color 16" ];
    };
  };
}
