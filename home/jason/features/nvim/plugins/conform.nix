{ pkgs, lib, config, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs; [
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
      hclfmt
    ];

    plugins.conform-nvim = {
      enable = true;

      settings = {
        formatters = {
          prettier-svelte = {
            command = "prettier";
            args = [ "--stdin-filepath" "$FILENAME" ];
          };
          prettier = config.lib.nixvim.mkRaw
            /* lua */
            ''
              {
                command = function(self, bufnr)
                    local util = require("conform.util")
                    local cmd = util.find_executable({ ".yarn/sdks/prettier/bin/prettier.cjs" }, "")(self, bufnr)

                    if cmd ~= "" then
                      return cmd
                    end

                    return util.from_node_modules("prettier")(self, bufnr) or "${lib.getExe pkgs.nodePackages.prettier}"
                  end
              }
            '';
          prettier-helm = {
            command = "prettier";
            args = [ "--no-bracket-spacing" "--parser" "yaml" "--stdin-filepath" "$FILENAME" ];
          };
          rustfmt = {
            command = "rustfmt";
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
          yaml = [ "prettier-helm" ];
          "yaml.ghaction" = [ "prettier-helm" ];
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
          hcl = [ "hcl" ];
          "_" = [ "trim_whitespace" ];
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
