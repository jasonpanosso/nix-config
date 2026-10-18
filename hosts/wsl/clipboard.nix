{ pkgs, ... }:

let
  win32yank = pkgs.stdenvNoCC.mkDerivation {
    pname = "win32yank";
    version = "0.1.1";
    src = pkgs.fetchurl {
      url = "https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip";
      hash = "sha256-JHyaBblDh6iEtJ09sT+AaxZ338OAIPlV9xm+aQImDNY=";
    };
    nativeBuildInputs = [ pkgs.unzip ];
    unpackPhase = "unzip $src";
    installPhase = "install -Dm755 win32yank.exe $out/bin/win32yank.exe";
  };
in
{
  clipboard = {
    copy = "${win32yank}/bin/win32yank.exe -i --crlf";
    paste = "${win32yank}/bin/win32yank.exe -o --lf";
  };
}
