{
  programs.nixvim = {
    # https://github.com/nix-community/nixvim/issues/989#issuecomment-2333728503
    autoCmd = [
      {
        event = "FileType";
        pattern = "helm";
        command = "LspRestart";
      }
    ];

    plugins.lsp.servers.helm_ls.enable = true;
    plugins.helm.enable = true;
  };
}
