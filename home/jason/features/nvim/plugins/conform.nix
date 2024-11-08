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
      sqlfluff
      google-java-format
      terraform
    ];

    plugins.conform-nvim = {
      enable = true;

      settings = {
        formatters = {
          prettier-svelte = {
            command = "prettier";
            args = [ "--stdin-filepath" "$FILENAME" ];
          };
          rustfmt = {
            command = "rustfmt";
            args = [ "--edition=2021" ];
          };
          sqlfluff = {
            command = "sqlfluff";
            stdin = true;
            args = [ "fix" "--dialect=postgres" "--force" "-" ];
          };
        };

        formatters_by_ft = {
          lua = [ "stylua" ];
          nix = [ "nixpkgs_fmt" ];
          typescript = [ "prettier" ];
          javascript = [ "prettier" ];
          typescriptreact = [ "prettier" ];
          javascriptreact = [ "prettier" ];
          svelte = [ "prettier-svelte" ];
          markdown = [ "prettier" ];
          html = [ "prettier" ];
          htmldjango = [ "djlint" ];
          sh = [ "beautysh" ];
          zsh = [ "beautysh" ];
          yaml = [ "prettier" ];
          toml = [ "taplo" ];
          cs = [ "csharpier" ];
          rust = [ "rustfmt" ];
          go = [ "gofmt" ];
          python = [ "ruff_format" ];
          sql = [ "sqlfluff" ];
          css = [ "prettier" ];
          json = [ "prettier" ];
          jsonc = [ "prettier" ];
          java = [ "google-java-format" ];
          terraform = [ "terraform_fmt" ];
          "*" = [ "trim_whitespace" ];
        };
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
