{
  inputs,
  config,
  withSystem,
  ...
}:

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

  flake.homeConfigurations."jason@wsl" = withSystem "x86_64-linux" (
    { pkgs, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = with homeManager; [
        base
        jason
        linux
        shell
        nvim
        foot
        pinentry-gnome3
        wsl
        {
          # no desktop on wsl
          dconf.enable = false;
        }
      ];
    }
  );

  flake.modules.nixos.wsl = {
    imports = [ inputs.nixos-wsl.nixosModules.default ];

    nixpkgs.hostPlatform = "x86_64-linux";
    networking.hostName = "wsl";
    system.stateVersion = "26.05";

    wsl = {
      enable = true;
      defaultUser = "jason";
    };
  };
}
