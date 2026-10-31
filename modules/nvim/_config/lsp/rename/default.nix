{
  extraConfigLua = builtins.readFile ./rename.lua;

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>rn";
      action.__raw = "function() _M.lsp_rename() end";
      options = {
        silent = true;
        desc = "LSP: [R]e[N]ame";
      };
    }
  ];
}
