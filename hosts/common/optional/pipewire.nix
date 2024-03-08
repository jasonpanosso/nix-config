{
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;

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
}
