{ pkgs, ... }:

{
  home.packages = [ pkgs.github-cli pkgs.git-crypt ];

  programs.git = {
    enable = true;
    userName = "jasonpanosso";
    userEmail = "jasonpanosso@protonmail.com";
    lfs.enable = true;

    extraConfig = {
      push = { autoSetupRemote = true; };
    };
  };
}
