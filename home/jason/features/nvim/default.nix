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
    globals.mapleader = " ";
  };
}
