{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      typescript-tools-nvim
    ];
    extraConfigLua = builtins.readFile ./typescript-tools.lua;

    keymaps = [
      {
        mode = [ "n" ];
        key = "gs";
        action = "<cmd>TSToolsGoToSourceDefinition<CR>";
        options = {
          silent = true;
          desc = "LSP: [G]oto [S]ource";
        };
      }
    ];
  };
}
