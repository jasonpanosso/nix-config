require('actions-preview').setup({
  diff = {
    algorithm = 'patience',
    ignore_whitespace = true,
  },

  telescope = {
    initial_mode = 'normal',
  },
})
