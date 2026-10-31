local lsp_border = {
  { '╭', 'NormalFloat' },
  { '─', 'NormalFloat' },
  { '╮', 'NormalFloat' },
  { '│', 'NormalFloat' },
  { '╯', 'NormalFloat' },
  { '─', 'NormalFloat' },
  { '╰', 'NormalFloat' },
  { '│', 'NormalFloat' },
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(function(_nil, result, ctx, config)
  if result then
    return vim.lsp.handlers.hover(_nil, result, ctx, config)
  end
end, { border = lsp_border })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = lsp_border })

local signs = {
  Error = ' ',
  Warn = ' ',
  Info = ' ',
  Hint = ' ',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  float = {
    show_header = false,
    border = lsp_border,
  },
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = {
    prefix = '',
    source = "if_many",
  },
})
