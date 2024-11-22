{
  programs.nixvim.plugins.lsp.servers.eslint = {
    enable = true;
    settings = {
      workingDirectories.mode = "location";
    };
  };
}
