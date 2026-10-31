# A plain nixvim module: used by both homeManager.nvim and packages.nvim
{ pkgs, ... }:

{
  imports = [
    ./options.nix
    ./user-commands.nix
    ./filetypes.nix
    ./lsp
    ./plugins
    ./general-keymaps.nix
  ];

  viAlias = true;
  plugins.web-devicons.enable = true;
  globals.mapleader = " ";

  extraPlugins = with pkgs.vimPlugins; [ vim-rzip ];
  extraPackages = [ pkgs.ripgrep ];
}
