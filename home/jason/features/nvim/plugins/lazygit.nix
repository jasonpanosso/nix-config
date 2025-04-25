{
  programs.nixvim = {
    plugins.lazygit = {
      enable = true;
    };

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
