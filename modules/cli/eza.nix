{
  flake.modules.homeManager.cli = {
    programs.eza = {
      enable = true;
      git = true;
      enableZshIntegration = true;
      icons = "auto";
    };
  };
}
