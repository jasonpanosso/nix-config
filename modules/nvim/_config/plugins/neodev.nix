{ pkgs, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    neodev-nvim
  ];
}
