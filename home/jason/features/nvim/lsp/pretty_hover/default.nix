{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ pretty_hover ];
    extraConfigLua = builtins.readFile ./pretty_hover.lua;

    keymaps = [
      {
        mode = [ "n" ];
        key = "K";
        action = "require('pretty_hover').hover";
        lua = true;
        options = {
          silent = true;
          desc = "LSP: Hover Documentation";
        };
      }
    ];
  };
}
