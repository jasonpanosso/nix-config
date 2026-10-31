{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ pretty_hover ];
    extraConfigLua = builtins.readFile ./pretty_hover.lua;

    keymaps = [
      {
        mode = [ "n" ];
        key = "K";
        action.__raw = "require('pretty_hover').hover";
        options = {
          silent = true;
          desc = "LSP: Hover Documentation";
        };
      }
    ];
  };
}
