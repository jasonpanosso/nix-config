{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.lsp.servers = {
      bashls.enable = true;
      clangd.enable = true;
      cssls.enable = true;
      dockerls.enable = true;
      gopls.enable = true;
      helm_ls.enable = true;
      html.enable = true;
      jsonls.enable = true;
      # marksman.enable = true;
      nil_ls.enable = true;
      pyright.enable = true;
      svelte.enable = true;
      taplo.enable = true;
      terraformls.enable = true;
      yamlls.enable = true;

      eslint = {
        enable = true;
        rootMarkers = [ "package.json" ];
      };

      lua_ls = {
        enable = true;

        settings = {
          diagnostics.globals = [ "vim" ];
          runtime.version = "LuaJIT";
          workspace.library = [
            # lua
            ''
              (function()
                local lib = {}
                for _, path in ipairs(vim.api.nvim_get_runtime_file('lua', true)) do
                  lib[#lib + 1] = path:sub(1, -5)
                end
                return lib
              end)()
            ''
          ];
        };
      };

      rust_analyzer = {
        enable = true;
        packageFallback = true;
        installRustc = false;
        installCargo = false;
        settings = {
          cargo = {
            targetDir = true;
          };
          check = {
            command = "clippy";
            allTargets = true;
          };
          checkOnSave = true;
        };
      };

      tailwindcss = {
        enable = true;

        filetypes = [
          "django-html"
          "htmldjango"
          "edge"
          "gohtml"
          "gohtmltmpl"
          "handlebars"
          "html"
          "htmlangular"
          "css"
          "less"
          "postcss"
          "sass"
          "scss"
          "stylus"
          "sugarss"
          "javascriptreact"
          "typescriptreact"
          "vue"
          "svelte"
          "templ"
        ];

        rootMarkers = [ "package.json" ];
      };
    };

    # helm
    plugins.helm.enable = true;
    # https://github.com/nix-community/nixvim/issues/989#issuecomment-2333728503
    autoCmd = [
      {
        event = "FileType";
        pattern = "helm";
        command = "LspRestart";
      }
    ];

    # terraform
    extraPackages = [ pkgs.terraform-ls ];
    extraConfigLua = /* lua */ ''
      vim.filetype.add({
        extension = {
          tf = "terraform",
        },
      })
    '';
  };
}
