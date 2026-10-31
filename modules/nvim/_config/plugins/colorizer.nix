{
  programs.nixvim.plugins.colorizer = {
    enable = true;
    settings = {
      fileTypes = [
        "lua"
        "css"
        "html"
        "sass"
        "less"
        "typescriptreact"
        "conf"
        "config"
      ];
    };
  };
}
