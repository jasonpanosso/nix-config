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

-- shared with the signature help keymap; vim.lsp.buf.* take the border directly
_M.lsp_border = lsp_border

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
    source = 'if_many',
  },
})
