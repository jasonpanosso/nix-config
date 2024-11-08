{
  programs.nixvim = {
    plugins.lsp.servers.terraformls.enable = true;
    extraConfigLua = /* lua */ ''
      vim.filetype.add({
        extension = {
          tf = "terraform",
        },
      })
    '';
  };
}
