{ inputs, config, ... }:

let
  inherit (config.flake.modules) nixos homeManager;
in
{
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    modules = with nixos; [
      base
      jason
      docker
      wsl
    ];
  };

  flake.modules.nixos.wsl = {
    imports = [ inputs.nixos-wsl.nixosModules.default ];

    nixpkgs.hostPlatform = "x86_64-linux";
    networking.hostName = "wsl";
    system.stateVersion = "26.05";

    wsl = {
      enable = true;
      defaultUser = "jason";
    };

    home-manager.users.jason = {
      imports = with homeManager; [
        base
        jason
        cli
        nvim
        foot
        pinentry-gnome3
        wsl
      ];

      # no desktop on wsl
      dconf.enable = false;
    };
  };
}
