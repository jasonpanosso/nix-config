{
  programs.nixvim.plugins.fidget = {
    enable = true;
    settings = {
      progress.lsp.progress_ringbuf_size = 16384;
      progress.ignore = [ "eslint" ];
    };
  };
}
