{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ breadcrumbs-nvim ];
    extraConfigLua = #lua
      ''
        require("breadcrumbs").setup()
      '';
  };
}
