{
  programs.nixvim = {
    plugins.typescript-tools = {
      enable = true;

      settings = {
        separateDiagnosticServer = true;
        publishDiagnosticOn = "insert_leave";
      };
    };

    keymaps = [
      {
        mode = [ "n" ];
        key = "gs";
        action = "<cmd>TSToolsGoToSourceDefinition<CR>";
        options = {
          silent = true;
          desc = "LSP: [G]oto [S]ource";
        };
      }
    ];
  };
}
