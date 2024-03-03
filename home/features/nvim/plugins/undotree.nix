{
  programs.nixvim = {
    plugins.undotree = {
      enable = true;
    };

    keymaps = [
      {
        mode = [ "n" "v" ];
        key = "<leader>u";
        action = "<cmd>UndotreeToggle<CR>";
        options = {
          silent = true;
          desc = "[U]ndo tree toggle";
        };
      }
    ];
  };
}
