{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      capabilities = #lua
        ''
          capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        '';
    };

    extraConfigLua = builtins.readFile ./prettify_lsp.lua;

    keymaps = [
      {
        mode = [ "n" ];
        key = "<leader>li";
        action = "<cmd>LspInfo<CR>";
        options = {
          silent = true;
          desc = "[L]SP [I]nfo";
        };
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>lr";
        action = "<cmd>LspStop<CR><cmd>sleep 100m<CR><cmd>LspStart<CR>";
        options = {
          desc = "[L]sp [R]estart";
        };
      }

      {
        mode = [ "n" ];
        key = "<leader>k";
        action = "vim.lsp.buf.signature_help";
        lua = true;
        options = {
          silent = true;
          desc = "LSP: Signature Help";
        };
      }
    ];
  };

  imports = [
    ./inlayhints
    ./fidget.nix
    ./lspsaga
    ./servers
    ./rustaceanvim.nix
    ./typescript-tools.nix
    ./roslyn.nix
  ];
}
