{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      auto-hlsearch-nvim
    ];
    extraConfigLua = "require('auto-hlsearch').setup()";
  };
}
