{
  programs.nixvim.plugins.nvim-colorizer = {
    enable = true;
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
}
