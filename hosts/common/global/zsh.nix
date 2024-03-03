{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    syntaxHighlighting = {
      enable = true;
    };
  };
}
