{
  programs.nixvim =
    {
      keymaps = [
        {
          mode = [ "n" "v" ];
          key = "<leader>pv";
          action.__raw = "require('oil').open_float";
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
            border = "rounded";
            padding = 10;
            max_width = 60;
            win_options = {
              winblend = 0;
            };
          };

          keymaps = {
            "g?" = "actions.show_help";
            "<CR>" = "actions.select";
            "<esc>" = "actions.close";
            "<C-r>" = "actions.refresh";
            "<BS>" = "actions.parent";
            "_" = "actions.open_cwd";
          };
        };
      };
    };
}
