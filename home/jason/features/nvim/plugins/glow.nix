{
  programs.nixvim = {
    plugins.glow = {
      enable = true;
    };

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
