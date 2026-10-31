{
  flake.modules.homeManager.cli = {
    programs.fzf = {
      enable = true;
      defaultOptions = [ "--color 16" ];
    };
  };
}
