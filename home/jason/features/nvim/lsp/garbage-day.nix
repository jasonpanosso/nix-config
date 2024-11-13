{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ garbage-day ];
    extraConfigLua = #lua
      ''
        require('garbage-day').setup({
          aggressive_mode = false,
          notifications = true,
          retries = 4,
          excluded_lsp_clients = { 'jdtls', 'marksman', 'lua_ls' },
        })
      '';
  };
}
