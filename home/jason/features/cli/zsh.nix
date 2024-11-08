{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autosuggestions.enable = true;
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

    initExtra = /* sh */ ''
      bindkey "''${key[Up]}" up-line-or-search
      bindkey "''${key[Down]}" down-line-or-search
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
