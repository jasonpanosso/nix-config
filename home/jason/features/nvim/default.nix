{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
    ./user-commands.nix
    ./lsp
    ./plugins
    ./general-keymaps.nix
  ];

  home.packages = with pkgs; [
    ripgrep
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.nixvim = {
    enable = true;
    viAlias = true;
    plugins.web-devicons.enable = true;
    globals.mapleader = " ";

    extraPlugins = with pkgs.vimPlugins; [ vim-rzip ];
  };
}
