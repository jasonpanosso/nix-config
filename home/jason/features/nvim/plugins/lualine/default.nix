{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ lualine-nvim ];
    extraConfigLua = builtins.readFile ./lualine.lua;
  };
}
