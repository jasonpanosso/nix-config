require('lsp-inlayhints').setup({
  inlay_hints = {
    parameter_hints = {
      show = false,
    },
    type_hints = {
      show = true,
      prefix = '',
      separator = ', ',
      remove_colon_start = false,
      remove_colon_end = false,
    },
    labels_separator = '  ',
    highlight = 'LspInlayHint',
    priority = 0,
  },
  enabled_at_startup = true,
  debug_mode = false,
})

vim.api.nvim_create_augroup('LspAttach_inlayhints', {})
vim.api.nvim_create_autocmd('LspAttach', {
  group = 'LspAttach_inlayhints',
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require('lsp-inlayhints').on_attach(client, bufnr)
  end,
})
