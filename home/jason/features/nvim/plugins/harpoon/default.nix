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
        action.__raw =
          /* lua */
          ''
            function()
              local harpoon = require('harpoon')
              harpoon.ui:toggle_quick_menu(harpoon:list())
            end
          '';
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>a";
        action.__raw = "function() require('harpoon'):list():add() end";
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>1";
        action.__raw = "function() require('harpoon'):list():select(1) end";
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>2";
        action.__raw = "function() require('harpoon'):list():select(2) end";
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>3";
        action.__raw = "function() require('harpoon'):list():select(3) end";
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>4";
        action.__raw = "function() require('harpoon'):list():select(4) end";
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>5";
        action.__raw = "function() require('harpoon'):list():select(5) end";
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>6";
        action.__raw = "function() require('harpoon'):list():select(6) end";
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>7";
        action.__raw = "function() require('harpoon'):list():select(7) end";
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>8";
        action.__raw = "function() require('harpoon'):list():select(8) end";
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>9";
        action.__raw = "function() require('harpoon'):list():select(9) end";
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>0";
        action.__raw = "function() require('harpoon'):list():select(10) end";
      }
    ];
  };
}
