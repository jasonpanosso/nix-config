{
  homeManager.modules.base = {
    programs.fd = {
      enable = true;
      ignores = [
        ".git/"
        "node_modules/"
      ];
    };
  };
}
