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
      key = "<leader>o";
      action = "<cmd>Lspsaga outline<CR>";
      options = {
        silent = true;
        desc = "LSP: Toggle [O]utline";
      };
    }

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
      key = "<leader>ca";
      action = "<cmd>Lspsaga code_action<CR>";
      options = {
        silent = true;
        desc = "LSP: [C]ode [A]ction";
      };
    }

    {
      mode = [ "n" ];
      key = "gh";
      action = "<cmd>Lspsaga lsp_finder<CR>";
      options = {
        silent = true;
        desc = "LSP: Symbol Info";
      };
    }

    {
      mode = [ "n" ];
      key = "gd";
      action = "<cmd>Lspsaga goto_definition<CR>";
      options = {
        silent = true;
        desc = "LSP: [G]oto [D]efinition";
      };
    }

    {
      mode = [ "n" ];
      key = "gt";
      action = "<cmd>Lspsaga goto_type_definition<CR>";
      options = {
        silent = true;
        desc = "LSP: [G]oto [T]ype definition";
      };
    }

    {
      mode = [ "n" ];
      key = "<leader>pt";
      action = "<cmd>Lspsaga peek_type_definition<CR>";
      options = {
        silent = true;
        desc = "LSP: [P]eek [T]ype definition";
      };
    }

    {
      mode = [ "n" ];
      key = "<leader>pd";
      action = "<cmd>Lspsaga peek_definition<CR>";
      options = {
        silent = true;
        desc = "LSP: [P]eek [D]efinition";
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
      key = "[e";
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
      action = "<cmd>Lspsaga Lspsaga hover_doc ++keep<CR>";
      options = {
        silent = true;
        desc = "LSP: Keep Hover Documentation";
      };
    }

    {
      mode = [ "n" ];
      key = "K";
      action = "<cmd>Lspsaga hover_doc<CR>";
      options = {
        silent = true;
        desc = "LSP: Hover Documentation";
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
