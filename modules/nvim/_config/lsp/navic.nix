{
  plugins.navic = {
    enable = true;
    settings = {
      lsp = {
        auto_attach = true;
        preference = [
          "typescript-tools"
        ];
      };
      highlight = true;
      separator = " › ";
    };
  };
}
