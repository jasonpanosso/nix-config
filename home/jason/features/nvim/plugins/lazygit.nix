{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      lazygit-nvim
    ];

    keymaps = [
      {
        mode = [ "n" "v" ];
        key = "<leader>go";
        action = "<cmd>LazyGit<CR>";
        options = {
          silent = true;
          desc = "[P]roject [V]iew";
        };
      }
    ];
  };
}
