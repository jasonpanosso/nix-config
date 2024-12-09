{
  programs.nixvim.plugins.lsp.servers.tailwindcss = {
    enable = true;

    filetypes = [
      "django-html"
      "htmldjango"
      "edge"
      "gohtml"
      "gohtmltmpl"
      "handlebars"
      "html"
      "htmlangular"
      "css"
      "less"
      "postcss"
      "sass"
      "scss"
      "stylus"
      "sugarss"
      "javascriptreact"
      "typescriptreact"
      "vue"
      "svelte"
      "templ"
    ];

    rootDir = #lua
      ''
        function(fname)
            local util = require('lspconfig.util')
            return util.root_pattern('tailwind.config.js', 'tailwind.config.ts')(fname) or util.path.dirname(fname)
        end,
      '';
  };
}

