{ pkgs, ... }:

let
  harpoon2 = pkgs.vimUtils.buildVimPlugin {
    pname = "harpoon2";
    version = "2024-02-27";
    src = pkgs.fetchgit
      {
        url = "https://github.com/ThePrimeagen/harpoon";
        rev = "a38be6e0dd4c6db66997deab71fc4453ace97f9c";
        hash = "sha256-RjwNUuKQpLkRBX3F9o25Vqvpu3Ah1TCFQ5Dk4jXhsbI=";
      };

    meta.homepage = "https://github.com/ThePrimeagen/harpoon/tree/harpoon2";
  };

  harpoon-tabline =
    pkgs.vimUtils.buildVimPlugin {
      pname = "harpoon-tabline";
      version = "2024-02-27";
      src = pkgs.fetchgit
        {
          url = "https://github.com/jasonpanosso/harpoon-tabline.nvim";
          rev = "37a15cfd9c4dac32e5be37b41491eb81082f6afe";
          hash = "sha256-ypJdBXLZccWilUo6wLJc/xYtXxF2suyxFDPWqLVrD0s=";
        };
      meta.homepage = "https://github.com/jasonpanosso/harpoon-tabline.nvim/";
    };
in
{
  programs.nixvim = {
    extraPlugins = [
      harpoon2
      harpoon-tabline
    ];

    extraConfigLua = builtins.readFile ./harpoon.lua;

    keymaps = [

      {
        mode = [ "n" "v" ];
        key = "<leader>h";
        action =
          # lua
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
