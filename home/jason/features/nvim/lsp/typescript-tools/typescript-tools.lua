local util = require('lspconfig.util')

require('typescript-tools').setup({
  root_dir = function(fname)
    local git_root = util.find_git_ancestor(fname)
    if git_root then
      return git_root
    end

    return util.root_pattern('tsconfig.json', 'package.json')(fname) or util.path.dirname(fname)
  end,
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = 'insert_leave',
    expose_as_code_action = { 'all' },
    tsserver_path = nil,
    tsserver_plugins = {},
    tsserver_max_memory = 'auto',
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    tsserver_locale = 'en',
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    code_lens = 'off',
    disable_member_code_lens = true,
  },
})
