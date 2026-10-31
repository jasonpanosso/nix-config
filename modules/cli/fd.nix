{
  flake.modules.homeManager.cli = {
    programs.fd = {
      enable = true;
      ignores = [
        ".git/"
        "node_modules/"
      ];
    };
  };
}
