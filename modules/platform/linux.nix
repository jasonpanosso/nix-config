{
  homeManager.modules.linux =
    { pkgs, ... }:
    {
      systemd.user.startServices = "sd-switch";

      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = true;
      };

      home.packages = with pkgs; [
        ethtool # query/control network device driver & hw settings
        iotop # io
        lm_sensors # for `sensors` command
        strace # sys calls
        sysstat # sys perf monitoring tools
      ];
    };
}
