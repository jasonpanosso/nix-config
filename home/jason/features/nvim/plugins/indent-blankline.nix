{
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    scope.enabled = false;
    exclude = {
      buftypes = [ "terminal" "nofile" "prompt" ];
    };
  };
}
