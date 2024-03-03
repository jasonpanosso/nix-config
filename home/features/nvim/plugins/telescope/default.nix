{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      telescope-nvim
      telescope-fzy-native-nvim
      project-nvim
    ];

    extraConfigLua = builtins.readFile ./telescope.lua;

    keymaps = [
      {
        mode = [ "n" ];
        key = "<leader><space>";
        action = "<cmd>Telescope buffers<CR>";
        options = {
          silent = true;
          desc = "[ ] Find existing buffers";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>sg";
        action = "<cmd>Telescope live_grep<CR>";
        options = {
          silent = true;
          desc = "[S]earch [G]rep";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>sf";
        action = "<cmd>Telescope find_files<CR>";
        options = {
          silent = true;
          desc = "[S]earch [F]iles";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>sh";
        action = "<cmd>Telescope help_tags<CR>";
        options = {
          silent = true;
          desc = "[S]earch [H]elp";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>sw";
        action = "<cmd>Telescope grep_string<CR>";
        options = {
          silent = true;
          desc = "[S]earch [W]ord";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>sd";
        action = "<cmd>Telescope diagnostics<CR>";
        options = {
          silent = true;
          desc = "[S]earch [D]iagnostics";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>sr";
        action = "<cmd>Telescope resume<CR>";
        options = {
          silent = true;
          desc = "[S]earch [R]esume";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>sm";
        action = "<cmd>Telescope keymaps<CR>";
        options = {
          silent = true;
          desc = "[S]earch Key[M]aps";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>sb";
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
        options = {
          silent = true;
          desc = "[S]earch [B]uffer";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>?";
        action = "<cmd>Telescope oldfiles<CR>";
        options = {
          silent = true;
          desc = "[?] Search recent files";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>sc";
        action = "<cmd>Telescope dap commands<CR>";
        options = {
          silent = true;
          desc = "[S]earch DAP [C]ommands";
        };
      }

      {
        mode = [ "n" ];
        key = "gr";
        action = "require('telescope.builtin').lsp_references";
        lua = true;
        options = {
          silent = true;
          desc = "[G]oto [R]eferences";
        };
      }

      {
        mode = [ "n" ];
        key = "gi";
        action = "require('telescope.builtin').lsp_implementations";
        lua = true;
        options = {
          silent = true;
          desc = "[G]oto [I]mplementations";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>db";
        action = "function() require('telescope.builtin').diagnostics({bufnr=0}) end";
        lua = true;
        options = {
          silent = true;
          desc = "[D]iagnostics [B]uffer";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>dw";
        action = "require('telescope.builtin').diagnostics";
        lua = true;
        options = {
          silent = true;
          desc = "[D]iagnostics [W]orkspace";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>ds";
        action = "require('telescope.builtin').lsp_document_symbols";
        lua = true;
        options = {
          silent = true;
          desc = "[D]ocument [S]ymbols";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>ws";
        action = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
        lua = true;
        options = {
          silent = true;
          desc = "[W]orkspace [S]ymbols";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>ci";
        action = "require('telescope.builtin').lsp_incoming_calls";
        lua = true;
        options = {
          silent = true;
          desc = "LSP: Incoming Calls";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>co";
        action = "require('telescope.builtin').lsp_outgoing_calls";
        lua = true;
        options = {
          silent = true;
          desc = "LSP: Outgoing Calls";
        };
      }
    ];
  };
}
