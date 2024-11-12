require('actions-preview').setup({
  diff = {
    algorithm = 'histogram',
    ignore_whitespace = true,
  },

  telescope = vim.tbl_extend('force', require('telescope.themes').get_cursor(), {
    previewer = false,
    initial_mode = 'normal',
    layout_strategy = 'vertical',
  }),
})
