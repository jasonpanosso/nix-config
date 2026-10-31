# NixOS under WSL: no bootloader, no desktop, Windows interop
{ inputs, config, ... }:

{
  hosts.wsl = {
    users = [ "jason" ];
    sshPublicKey = builtins.readFile ./ssh_host_ed25519_key.pub;

    module = {
      imports = [
        config.nixos.modules.base
        inputs.nixos-wsl.nixosModules.default
      ];

      wsl = {
        enable = true;
        defaultUser = "jason";
      };

      system.stateVersion = "26.05";

      home-manager.sharedModules = [ config.homeManager.modules.wsl ];
    };
  };

  homeManager.modules.wsl = {
    # no dconf service without a desktop
    dconf.enable = false;
  };
}
