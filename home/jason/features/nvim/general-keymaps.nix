{
  programs.nixvim.keymaps = [
    {
      mode = [ "n" "v" ];
      key = "H";
      action = "^";
      options = {
        desc = "Start of line";
      };
    }

    {
      mode = [ "n" "v" ];
      key = "L";
      action = "g_";
      options = {
        desc = "End of line";
      };
    }

    {
      mode = [ "n" ];
      key = "<leader>S";
      action = "<cmd>%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left><CR>";
      options = {
        desc = "I still do not know what this does";
      };
    }

    # bind Q to nop for following bdelete keymap:
    {
      mode = [ "n" "v" ];
      key = "Q";
      action = "<nop>";
    }
    {
      mode = [ "n" "v" ];
      key = "<S-q>";
      action = "<cmd>bdelete!<CR>";
    }

    {
      mode = [ "n" ];
      key = "<leader>x";
      action = "<cmd>!chmod +x %<CR>";
      options = {
        desc = "!chmod [X]";
      };
    }

    {
      mode = [ "n" "v" ];
      key = "<C-g>";
      action = "<C-a>";
      options = {
        desc = "Remap increment to avoid tmux prefix";
      };
    }

    {
      mode = [ "n" "v" ];
      key = "n";
      action = "nzzzv";
    }

    {
      mode = [ "n" "v" ];
      key = "N";
      action = "Nzzzv";
    }

    {
      mode = [ "n" "v" ];
      key = "<C-d>";
      action = "<C-d>zz";
    }

    {
      mode = [ "n" "v" ];
      key = "<C-u>";
      action = "<C-u>zz";
    }

    {
      mode = [ "v" ];
      key = "p";
      action = "_dP";
      options = {
        desc = "Better paste";
      };
    }

    {
      mode = [ "v" ];
      key = "<";
      action = "<gv";
      options = {
        desc = "Visual indent left";
      };
    }

    {
      mode = [ "v" ];
      key = ">";
      action = ">gv";
      options = {
        desc = "Visual indent right";
      };
    }
  ];
}
