{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      lsp-inlayhints-nvim
    ];
    extraConfigLua = builtins.readFile ./inlayhints.lua;
  };
}
