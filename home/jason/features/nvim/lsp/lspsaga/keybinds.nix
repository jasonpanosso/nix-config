{
  programs.nixvim.keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>rn";
      action = "<cmd>Lspsaga rename<CR>";
      options = {
        silent = true;
        desc = "LSP: [R]e[N]ame";
      };
    }

    {
      mode = [ "n" ];
      key = "<leader>prn";
      action = "<cmd>Lspsaga rename ++project<CR>";
      options = {
        silent = true;
        desc = "LSP: [P]roject [R]e[N]ame";
      };
    }

    {
      mode = [ "n" ];
      key = "<leader>o";
      action = "<cmd>Lspsaga outline<CR>";
      options = {
        silent = true;
        desc = "LSP: Toggle [O]utline";
      };
    }

    {
      mode = [ "n" ];
      key = "<leader>dl";
      action = "<cmd>Lspsaga show_line_diagnostics<CR>";
      options = {
        silent = true;
        desc = "LSP: [D]iagnostics [L]ine";
      };
    }

    {
      mode = [ "n" ];
      key = "<leader>dc";
      action = "<cmd>Lspsaga show_cursor_diagnostics<CR>";
      options = {
        silent = true;
        desc = "LSP: [D]iagnostics [C]ursor";
      };
    }

    {
      mode = [ "n" ];
      key = "]e";
      action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
      options = {
        silent = true;
        desc = "LSP: Jump Prev Diagnostic";
      };
    }

    {
      mode = [ "n" ];
      key = "e]";
      action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
      options = {
        silent = true;
        desc = "LSP: Jump Next Diagnostic";
      };
    }

    {
      mode = [ "n" ];
      key = "<leader>K";
      action = "<cmd>Lspsaga hover_doc ++keep<CR>";
      options = {
        silent = true;
        desc = "LSP: Keep Hover Documentation";
      };
    }
  ];
}
