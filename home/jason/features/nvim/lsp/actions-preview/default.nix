{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ actions-preview ];
    extraConfigLua = builtins.readFile ./actions-preview.lua;

    keymaps = [
      {
        mode = [ "n" "v" ];
        key = "<leader>ca";
        action.__raw = "require('actions-preview').code_actions";
        options = {
          silent = true;
          desc = "[C]ode [A]ctions";
        };
      }
    ];
  };
}
