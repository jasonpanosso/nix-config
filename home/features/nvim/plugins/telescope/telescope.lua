local actions = require('telescope.actions')

require('telescope').setup({
  defaults = {
    file_ignore_patterns = { 'node_modules', '_Index', '.git', '*.asset', '*.meta' },
    path_display = { 'smart' },
    mappings = {
      n = {
        ['q'] = actions.close,
      },
      i = {
        ['<C-n>'] = actions.move_selection_next,
        ['<C-p>'] = actions.move_selection_previous,
      },
    },
    prompt_prefix = ' ',
    selection_caret = ' ',
    layout_config = {
      horizontal = { prompt_position = 'bottom', preview_width = 0.5, results_width = 0.5 },
      vertical = { mirror = false },
    },
    sorting_strategy = 'ascending',
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    hidden = true,
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim',
      '--hidden',
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
})

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('projects')
