{
  homeManager.profiles.base = {
    programs.fd = {
      enable = true;
      ignores = [
        ".git/"
        "node_modules/"
      ];
    };
  };
}
