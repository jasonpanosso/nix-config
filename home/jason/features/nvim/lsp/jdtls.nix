{ lib, pkgs, ... }:

{
  home.packages = [ pkgs.jdt-language-server ];

  programs.nixvim.plugins = {
    jdtls = {
      enable = true;
      settings = {
        cmd = [
          "${lib.getExe pkgs.jdt-language-server}"
          "-data"
          "~/.cache/jdtls/workspace"
        ];
      };
    };
  };
}

