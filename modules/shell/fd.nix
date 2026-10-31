{
  flake.modules.homeManager.shell = {
    programs.fd = {
      enable = true;
      ignores = [
        ".git/"
        "node_modules/"
      ];
    };
  };
}
