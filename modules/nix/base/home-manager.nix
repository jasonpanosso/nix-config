{ inputs, config, ... }:

{
  flake.modules.nixos.base = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      backupFileExtension = ".bak";
      useGlobalPkgs = true;
      useUserPackages = true;

      # every NixOS home is a linux home
      sharedModules = [ config.flake.modules.homeManager.linux ];
    };
  };

  flake.modules.homeManager.base =
    { lib, config, ... }:
    {
      programs.home-manager.enable = true;

      home = {
        stateVersion = lib.mkDefault "26.05";
        sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
      };
    };
}
