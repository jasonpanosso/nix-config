{ lib, pkgs, ... }:

{
  extraPackages = [ pkgs.jdt-language-server ];

  plugins = {
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
