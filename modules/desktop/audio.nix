{
  nixos.profiles.desktop =
    { config, ... }:
    {
      environment.systemPackages = [ config.services.pipewire.package.jack ];

      security.rtkit.enable = true;

      services.pulseaudio.enable = false;
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
      };
    };

  # volume mixer for the pipewire-pulse server above
  homeManager.profiles.desktop =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.pavucontrol ];
    };
}
