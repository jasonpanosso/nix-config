# This file holds config that i use on all hosts
{ inputs, outputs, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./sops.nix
  ];

  environment.systemPackages = with pkgs; [ git ];
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    useUserPackages = true;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  # enabled here to allow users to login with zsh, more configuration in hm
  programs.zsh.enable = true;

  hardware.enableRedistributableFirmware = true;

  # speed up boot time
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.network.wait-online.enable = false;

  boot.initrd.systemd.enable = true;

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];
}
