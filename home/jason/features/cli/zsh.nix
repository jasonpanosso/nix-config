{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autocd = true;
    syntaxHighlighting = {
      enable = true;
    };

    shellAliases = {
      sl = "eza";
      ls = "eza";
      l = "eza -l";
      la = "eza -la";
      ip = "ip --color=auto";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "gitfast"
        "rbw"
        "jsontools"
      ];
    };

    initContent = /* sh */ ''
      autoload zkbd
      autoload up-line-or-history
      autoload down-line-or-history

      [[ -n ''${key[PageUp]} ]] && bindkey "''${key[PageUp]}" up-line-or-history
      [[ -n ''${key[PageDown]} ]] && bindkey "''${key[PageDown]}" down-line-or-history

      [[ -n ''${key[Up]} ]] && bindkey "''${key[Up]}" up-line-or-search
      [[ -n ''${key[Down]} ]] && bindkey "''${key[Down]}" down-line-or-search
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      character.success_symbol = "[➜](bold green)";
      character.error_symbol = "[➜](bold red)";
      aws.disabled = true;
    };
  };

  programs.fzf = {
    enableZshIntegration = true;
  };
}
