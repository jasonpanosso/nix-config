{
  programs.nixvim.plugins.lsp.servers.eslint = {
    enable = true;
    rootMarkers = [ "package.json" ];
  };
}
