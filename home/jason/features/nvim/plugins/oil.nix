{
  programs.nixvim =
    {
      keymaps = [
        {
          mode = [ "n" "v" ];
          key = "<leader>pv";
          action = "require('oil').open_float";
          lua = true;
          options = {
            silent = true;
            desc = "[P]roject [V]iew";
          };
        }
      ];

      plugins.oil = {
        enable = true;

        settings = {
          view_options = {
            show_hidden = true;
          };

          float = {
            padding = 10;
            max_width = 60;
            win_options = {
              winblend = 0;
            };
          };

          keymaps = {
            "g?" = "actions.show_help";
            "<CR>" = "actions.select";
            "<C-s>" = "actions.select_vsplit";
            "<C-h>" = "actions.select_split";
            "<C-t>" = "actions.select_tab";
            "<C-p>" = "actions.preview";
            "<esc>" = "actions.close";
            "<C-r>" = "actions.refresh";
            "<BS>" = "actions.parent";
            "_" = "actions.open_cwd";
            "`" = "actions.cd";
            "~" = "actions.tcd";
            "g." = "actions.toggle_hidden";
          };
        };
      };
    };
}
