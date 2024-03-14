{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs; [
      prettierd
      nodePackages.prettier
      stylua
      rustfmt
      nixpkgs-fmt
      beautysh
      djlint
      taplo
      go
      (with dotnetCorePackages; combinePackages [
        sdk_6_0
        sdk_7_0
      ])
      csharpier
      ruff
    ];

    plugins.conform-nvim = {
      enable = true;
      formatters = {
        prettier-svelte = {
          command = "prettier";
          prepend_args = [ "--plugin=prettier-plugin-svelte" ];
        };
      };

      formattersByFt = {
        lua = [ "stylua" ];
        nix = [ "nixpkgs_fmt" ];
        typescript = [ "prettierd" ];
        javascript = [ "prettierd" ];
        typescriptreact = [ "prettierd" ];
        javascriptreact = [ "prettierd" ];
        svelte = [ "prettier-svelte" ];
        markdown = [ "prettierd" ];
        html = [ "prettierd" ];
        htmldjango = [ "djlint" ];
        sh = [ "beautysh" ];
        zsh = [ "beautysh" ];
        yaml = [ "prettierd" ];
        toml = [ "taplo" ];
        cs = [ "csharpier" ];
        rust = [ "rustfmt" ];
        go = [ "gofmt" ];
        python = [ "ruff_format" ];
        sql = [ "sqlfluff" ];
        css = [ "prettierd" ];
        json = [ "prettierd" ];
        jsonc = [ "prettierd" ];
        "*" = [ "trim_whitespace" ];
      };
    };

    keymaps = [
      {
        mode = [ "n" "v" ];
        key = "<leader>lf";
        action =
          /* lua */
          ''
            function()
              require("conform").format({ async = true, lsp_fallback = true })
            end
          '';
        lua = true;
        options = {
          silent = true;
          desc = "Format";
        };
      }
    ];
  };
}
