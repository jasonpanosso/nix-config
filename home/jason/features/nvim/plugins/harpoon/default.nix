{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      harpoon2
      harpoon-tabline
    ];

    extraConfigLua = builtins.readFile ./harpoon.lua;

    keymaps = [

      {
        mode = [ "n" "v" ];
        key = "<leader>h";
        action =
          /* lua */
          ''
            function()
              local harpoon = require('harpoon')
              harpoon.ui:toggle_quick_menu(harpoon:list())
            end
          '';
        lua = true;
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>a";
        action = "function() require('harpoon'):list():append() end";
        lua = true;
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>1";
        action = "function() require('harpoon'):list():select(1) end";
        lua = true;
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>2";
        action = "function() require('harpoon'):list():select(2) end";
        lua = true;
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>3";
        action = "function() require('harpoon'):list():select(3) end";
        lua = true;
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>4";
        action = "function() require('harpoon'):list():select(4) end";
        lua = true;
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>5";
        action = "function() require('harpoon'):list():select(5) end";
        lua = true;
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>6";
        action = "function() require('harpoon'):list():select(6) end";
        lua = true;
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>7";
        action = "function() require('harpoon'):list():select(7) end";
        lua = true;
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>8";
        action = "function() require('harpoon'):list():select(8) end";
        lua = true;
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>9";
        action = "function() require('harpoon'):list():select(9) end";
        lua = true;
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>0";
        action = "function() require('harpoon'):list():select(0) end";
        lua = true;
      }
    ];
  };
}
