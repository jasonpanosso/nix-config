{
  homeManager.profiles.base =
    { pkgs, ... }:

    {
      home.packages = with pkgs; [
        kubectl
        kubectl-df-pv
        kubectl-example
        kubectl-neat
        kubectl-node-shell
        kubectl-view-secret
        kubectl-tree
      ];

      home.shellAliases = {
        k = "kubecolor";
      };

      programs.kubecolor = {
        enable = true;
        enableAlias = true;
        enableZshIntegration = true;
      };
    };
}
