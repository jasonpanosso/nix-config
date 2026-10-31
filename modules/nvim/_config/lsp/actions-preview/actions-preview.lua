require('actions-preview').setup({
  diff = {
    algorithm = 'patience',
    ignore_whitespace = true,
  },

  backend = { 'nui', 'telescope ' },

  nui = {
    dir = 'col',
    layout = {
      position = '50%',
      size = {
        width = '60%',
        height = '90%',
      },
      min_width = 40,
      min_height = 10,
      relative = 'editor',
    },

    -- options for preview area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
    preview = {
      size = '60%',
      border = {
        style = 'rounded',
        padding = { 0, 1 },
      },
    },

    -- options for selection area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu
    select = {
      size = '40%',
      border = {
        style = 'rounded',
        padding = { 0, 1 },
      },
    },

    keymap = {
      close = { '<Esc>', '<C-c>', 'q' },
      focus_next = { 'j', '<C-n>' },
      focus_prev = { 'k', '<C-p>' },
      submit = { '<CR>' },
    },
  },

  telescope = {
    initial_mode = 'normal',
  },
})
