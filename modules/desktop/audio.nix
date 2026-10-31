{
  nixos.modules.desktop = {
    security.rtkit.enable = true;
    services.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };

  # volume mixer for the pipewire-pulse server above
  homeManager.modules.desktop =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.pavucontrol ];
    };
}
