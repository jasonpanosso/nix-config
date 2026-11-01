{
  homeManager.profiles.linux =
    { pkgs, ... }:
    {
      systemd.user.startServices = "sd-switch";

      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = true;
      };

      services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;

      home.packages = with pkgs; [
        ethtool # query/control network device driver & hw settings
        iotop # io
        lm_sensors # for `sensors` command
        strace # sys calls
        sysstat # sys perf monitoring tools

        pinentry-gnome3
        gcr_4 # system prompter pinentry-gnome3 talks to outside GNOME
      ];
    };
}
