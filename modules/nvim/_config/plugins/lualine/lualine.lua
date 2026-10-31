local lualine = require('lualine')

-- Show macro recording status on statusline
local show_macro_recording = function()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end

vim.api.nvim_create_autocmd('RecordingEnter', {
  callback = function()
    lualine.refresh({ place = { 'statusline' } })
  end,
})
vim.api.nvim_create_autocmd('RecordingLeave', {
  callback = function()
    lualine.refresh({ place = { 'statusline' } })
  end,
})

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn' },
  symbols = { error = ' ', warn = ' ' },
  colored = false,
  always_visible = true,
}

local diff = {
  'diff',
  colored = false,
  symbols = { added = ' ', modified = ' ', removed = ' ' },
  cond = function()
    return vim.fn.winwidth(0) > 80
  end,
}

local filetype = {
  'filetype',
  icons_enabled = true,
}

local location = {
  'location',
  padding = 0,
}

local spaces = function()
  return 'spaces: ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
end

lualine.setup({
  options = {
    refresh = {
      statusline = 100,
    },
    globalstatus = true,
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'alpha', 'dashboard' },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { 'mode', show_macro_recording },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
    lualine_x = { diagnostics, diff, spaces, 'encoding', filetype },
    lualine_y = { location },
    lualine_z = { 'progress' },
  },
})
