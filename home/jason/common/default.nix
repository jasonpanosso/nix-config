{ lib, pkgs, config, outputs, inputs, ... }:

{
  imports = [
    inputs.stylix.homeManagerModules.stylix
    ../../../shared/stylix.nix
    ../features/cli
    ../features/nvim
    ../features/desktop/common
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "dotnet-sdk-7.0.410"
      ];
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
  };

  home = {
    username = lib.mkDefault "jason";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.11";
    sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
  };
}
