{
  flake.modules.homeManager.base =
    { lib, config, ... }:
    {
      programs.home-manager.enable = true;

      home = {
        stateVersion = lib.mkDefault "26.05";
        sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

        # back up clashing files instead of failing the switch
        sessionVariables.HOME_MANAGER_BACKUP_EXT = "bak";
      };
    };
}
