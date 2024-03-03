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

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = lsp_border })
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

-- vim.diagnostic.config({
--   float = { border = lsp_border },
--   signs = true,
--   update_in_insert = false,
--   underline = true,
--   severity_sort = true,
--   virtual_text = {
--     prefix = '🔥',
--     source = true,
--   },
-- })

vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
  local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.diagnostic.reset(ns, bufnr)
  return true
end
