{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ actions-preview ];
    extraConfigLua = builtins.readFile ./actions-preview.lua;

    keymaps = [
      {
        mode = [ "n" "v" ];
        key = "<leader>ca";
        action = "require('actions-preview').code_actions";
        lua = true;
        options = {
          silent = true;
          desc = "[C]ode [A]ctions";
        };
      }
    ];
  };
}
