{ inputs, config, ... }:

{
  # homes are part of the system: `nh os switch` activates both
  nixos.profiles.base = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      # back up clashing files instead of failing the switch
      backupFileExtension = "bak";
      # every NixOS home is a linux home
      sharedModules = [ config.homeManager.profiles.linux ];
    };
  };

  homeManager.profiles.base =
    { lib, config, ... }:
    {
      programs.home-manager.enable = true;

      home = {
        stateVersion = lib.mkDefault "26.05";
        sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
      };
    };
}
