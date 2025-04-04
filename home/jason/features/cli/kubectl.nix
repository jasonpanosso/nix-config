{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kubectl
    kubectl-cnpg
    kubectl-df-pv
    kubectl-doctor
    kubectl-example
    kubectl-neat
    kubectl-node-shell
    kubectl-view-secret
    kubectl-tree
  ];
}
