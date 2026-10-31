{ lib, pkgs, config, outputs, inputs, ... }:

let
  projectsDir = "${config.home.homeDirectory}/Programming";
  flakePath = "${projectsDir}/nix-config";
in
{
  imports = [
    inputs.stylix.homeModules.stylix
    ../../../shared/stylix.nix
    ../features/cli
    ../features/nvim
  ] ++ (builtins.attrValues outputs.homeModules);

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  # stylix's overlays set nixpkgs.overlays, which useGlobalPkgs forbids
  stylix.overlays.enable = false;

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    nh = {
      enable = true;
      flake = flakePath;
    };
  };

  home = {
    username = lib.mkDefault "jason";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "26.05";
    sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
    file.".ideavimrc".source = ./ideavimrc;
    activation.cloneNixConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run mkdir -p "${projectsDir}"
      if [ ! -d "${flakePath}" ]; then
        run ${pkgs.git}/bin/git clone https://github.com/jasonpanosso/nix-config "${flakePath}"
      fi
    '';
  };

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = true;
    };
  };
}
