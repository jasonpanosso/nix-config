{
  homeManager.profiles.linux =
    { lib, pkgs, ... }:
    {
      systemd.user.startServices = "sd-switch";

      # no dconf service without a desktop session
      dconf.enable = lib.mkDefault false;

      # no display to prompt on; graphical homes override
      services.gpg-agent.pinentry.package = lib.mkDefault pkgs.pinentry-curses;

      home.packages = with pkgs; [
        ethtool # query/control network device driver & hw settings
        iotop # io
        lm_sensors # for `sensors` command
        strace # sys calls
        sysstat # sys perf monitoring tools
      ];
    };
}
