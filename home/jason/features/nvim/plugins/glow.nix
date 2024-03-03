{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      glow-nvim
    ];

    extraConfigLua = "require('glow').setup()";

    keymaps = [
      {
        mode = [ "n" "v" ];
        key = "<leader>md";
        action = "<cmd>Glow<CR>";
        options = {
          silent = true;
          desc = "render [M]ark[D]own";
        };
      }
    ];
  };
}
