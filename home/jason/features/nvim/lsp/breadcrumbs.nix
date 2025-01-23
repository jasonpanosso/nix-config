{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ nvim-navic breadcrumbs-nvim ];
    extraConfigLua = #lua
      ''
        require("nvim-navic").setup {
          lsp = {
            auto_attach = true,
            preference = { 'tsserver' },
          },
          highlight = true,
        }

        require("breadcrumbs").setup()
      '';
  };
}
