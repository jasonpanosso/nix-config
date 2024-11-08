{ lib, pkgs, ... }:

{
  home.packages = [ pkgs.jdt-language-server ];

  programs.nixvim.plugins = {
    nvim-jdtls = {
      enable = true;
      data = "~/.cache/jdtls/workspace";
      cmd = [
        "${lib.getExe pkgs.jdt-language-server}"
      ];
    };
  };
}
