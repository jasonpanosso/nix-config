{
  home.shellAliases = {
    k = "kubecolor";
  };

  programs.kubecolor = {
    enable = true;
    enableAlias = true;
    enableZshIntegration = true;
  };
}
