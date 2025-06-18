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

    rootMarkers = [ "package.json" ];
  };
}

