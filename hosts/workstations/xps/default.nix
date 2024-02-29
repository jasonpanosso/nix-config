{ system, pkgs, lib, inputs, ... }:

{
  imports =
    [
      inputs.commonConfig
      ./hardware-configuration.nix
    ];

  networking.hostName = "xps";
  environment.systemPackages = with pkgs; [ vim git ];

  services.xserver.enable = true;
  users.users.jason = {
    isNormalUser = true;
    home = "/home/jason";
    extraGroups = [ "wheel" "networkmanager" ];
  };

}
