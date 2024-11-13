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

              vim.keymap.set('n', '<Leader>em', function()
                vim.cmd.RustLsp('expandMacro')
              end, { buffer = bufnr, silent = true })

              vim.keymap.set('n', '<Leader>ee', function()
                vim.cmd.RustLsp('explainError')
              end, { buffer = bufnr, silent = true })

              vim.keymap.set('n', '<Leader>co', function()
                vim.cmd.RustLsp('openCargo')
              end, { buffer = bufnr, silent = true })

              vim.keymap.set('n', '<Leader>do', function()
                vim.cmd.RustLsp('openDocs')
              end, { buffer = bufnr, silent = true })

              vim.keymap.set('n', '<Leader>pm', function()
                vim.cmd.RustLsp('parentModule')
              end, { buffer = bufnr, silent = true })
            end
          '';
      };
    };
  };
}
