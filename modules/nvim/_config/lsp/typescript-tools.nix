{
  programs.nixvim = {
    plugins.typescript-tools = {
      enable = true;
      settings = {
        root_dir = {
          __raw = /* lua */ ''
            function(fname)
              local util = require('lspconfig.util')
              local git_root = util.find_git_ancestor(fname)
              if git_root then
                return git_root
              end

              return util.root_pattern('tsconfig.json', 'package.json')(fname) or util.path.dirname(fname)
            end
          '';
        };
        settings = {
          separate_diagnostic_server = true;
          publish_diagnostic_on = "insert_leave";
          tsserver_max_memory = "auto";
          tsserver_format_options = { };
          tsserver_file_preferences = { };
          tsserver_locale = "en";
          complete_function_calls = false;
          include_completions_with_insert_text = true;
          code_lens = "off";
          disable_member_code_lens = true;
        };
      };

    };

    keymaps = [
      {
        mode = [ "n" ];
        key = "gs";
        action = "<cmd>TSToolsGoToSourceDefinition<CR>";
        options = {
          silent = true;
          desc = "LSP: [G]oto [S]ource";
        };
      }
    ];
  };
}
