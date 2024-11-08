{
  programs.nixvim = {
    plugins.typescript-tools = {
      enable = true;

      settings = {
        separate_diagnostic_server = true;
        publish_diagnostic_on = "insert_leave";
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
