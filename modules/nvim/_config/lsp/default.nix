{
  plugins.lsp = {
    enable = true;
    inlayHints = false;
    capabilities = # lua
      ''
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      '';
  };

  extraConfigLua = builtins.readFile ./prettify_lsp.lua;

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>li";
      action = "<cmd>checkhealth vim.lsp<CR>";
      options = {
        silent = true;
        desc = "[L]SP [I]nfo";
      };
    }

    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>lr";
      action = "<cmd>LspStop<CR><cmd>sleep 100m<CR><cmd>LspStart<CR>";
      options = {
        desc = "[L]sp [R]estart";
      };
    }

    {
      mode = [ "n" ];
      key = "<leader>k";
      action.__raw = "function() vim.lsp.buf.signature_help({ border = _M.lsp_border }) end";
      options = {
        silent = true;
        desc = "LSP: Signature Help";
      };
    }

    {
      mode = [ "n" ];
      key = "<leader>dl";
      action.__raw = "function() vim.diagnostic.open_float({ scope = 'line' }) end";
      options = {
        silent = true;
        desc = "LSP: [D]iagnostics [L]ine";
      };
    }

    {
      mode = [ "n" ];
      key = "<leader>dc";
      action.__raw = "function() vim.diagnostic.open_float({ scope = 'cursor' }) end";
      options = {
        silent = true;
        desc = "LSP: [D]iagnostics [C]ursor";
      };
    }

    {
      mode = [ "n" ];
      key = "<leader>rl";
      action = "<cmd>so $MYVIMRC<CR>";
      options = {
        silent = true;
        desc = "[R]e[L]oad init.lua";
      };
    }
  ];

  imports = [
    ./actions-preview
    ./fidget.nix
    ./garbage-day.nix
    ./rename
    ./navic.nix
    ./pretty_hover
    ./servers.nix
    ./rustaceanvim.nix
    ./jdtls.nix
  ];
}
