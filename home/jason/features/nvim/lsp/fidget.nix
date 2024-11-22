{
  programs.nixvim.plugins.fidget = {
    enable = true;
    progress.lsp.progressRingbufSize = 16384;
    progress.ignore = [ "eslint" ];
  };
}
