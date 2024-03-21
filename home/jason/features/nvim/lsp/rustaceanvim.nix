{
  programs.nixvim.plugins.rustaceanvim = {
    enable = true;

    server = {
      onAttach =
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
          end
        '';

      settings = /* lua */ ''
        function(project_root)
          local rust_analyzer_file = project_root .. "/rust-analyzer.json"

          if vim.fn.filereadable(rust_analyzer_file) == 1 then
            return require('rustaceanvim.config.server').load_rust_analyzer_settings(project_root)
          end

          return {
            checkOnSave = true,
            cargo = {
              features = "all",
            },
            check = {
              command = "clippy",
            },
          }
        end
      '';
    };
  };
}
