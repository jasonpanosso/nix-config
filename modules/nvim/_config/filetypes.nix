{
  programs.nixvim = {
    filetype = {
      pattern = {
        ".*/.github/workflows/.*%.ya?ml" = "yaml.ghaction";
      };
    };
  };
}
