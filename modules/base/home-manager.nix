{ inputs, ... }:

{
  flake.modules.nixos.base = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      backupFileExtension = ".bak";
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };

  flake.modules.homeManager.base =
    { lib, config, ... }:
    {
      # TODO: replace with machine facts
      imports = builtins.attrValues (import ../../home/modules);

      programs.home-manager.enable = true;
      systemd.user.startServices = "sd-switch";

      home = {
        stateVersion = lib.mkDefault "26.05";
        sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
      };

      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = true;
      };
    };
}
