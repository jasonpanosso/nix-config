{
  programs.nixvim.plugins.rustaceanvim = {
    enable = true;

    settings = {
      server = {
        on_attach =
          /* lua */
          ''
            function(client, bufnr)
              require('lsp-inlayhints').on_attach(client, bufnr)

              vim.keymap.set('n', '<Leader>rd', function()
                vim.cmd.RustLsp('debuggables')
              end, { buffer = bufnr, silent = true })

              vim.keymap.set('n', '<Leader>ca', function()
                vim.cmd.RustLsp('codeAction')
              end, { buffer = bufnr, silent = true })

              -- https://www.reddit.com/r/neovim/comments/12gvms4/this_is_why_your_higlights_look_different_in_90/
              vim.api.nvim_set_hl(0, '@lsp.type.macro', { link = 'Macro', default = true })
              vim.api.nvim_set_hl(0, '@lsp.type.decorator', { link = '@function', default = true })
            end
          '';

        default_settings =
          /* lua */
          ''
            function(project_root)
              return require('rustaceanvim.config.server').load_rust_analyzer_settings(project_root)
            end
          '';

      };
    };
  };
}
