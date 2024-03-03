{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      ignoreInstall = [ "phpdoc" "luau" ];
      ensureInstalled = "all";

      indent = true;
      folding = true;
      nixvimInjections = true;
      nixGrammars = true;
    };

    ts-autotag.enable = true;
    ts-context-commentstring = {
      enable = true;
      disableAutoInitialization = false;
    };

    treesitter-textobjects = {
      enable = true;

      select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "aa" = "@parameter.outer";
          "ia" = "@parameter.inner";
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
          "ii" = "@conditional.inner";
          "ai" = "@conditional.outer";
          "il" = "@loop.inner";
          "al" = "@loop.outer";
          "at" = "@comment.outer";
        };
      };

      move = {
        enable = true;
        gotoNextStart = {
          "]m" = "@function.outer";
          "]]" = "@class.outer";
        };
        gotoNextEnd = {
          "]M" = "@function.outer";
          "][" = "@class.outer";
        };
        gotoPreviousStart = {
          "[m" = "@function.outer";
          "[[" = "@class.outer";
        };
        gotoPreviousEnd = {
          "[M" = "@function.outer";
          "[]" = "@class.outer";
        };
      };

      swap = {
        enable = true;
        swapNext = {
          "<leader>si" = "@parameters.inner";
        };
        swapPrevious = {
          "<leader>so" = "@parameter.outer";
        };
      };
    };
  };

  programs.nixvim.extraConfigLua =
    #lua
    ''
      vim.api.nvim_command('set nofoldenable')

      -- indenting for jsx/tsx
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'javascriptreact', 'typescriptreact' },
        callback = function(opt)
          vim.bo[opt.buf].indentexpr = 'nvim_treesitter#indent()'
        end,
      })
    '';
}
