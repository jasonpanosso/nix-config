{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
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
    extraPlugins = with pkgs.vimPlugins; [ nvim-web-devicons ];
    globals.mapleader = " ";
  };
}
