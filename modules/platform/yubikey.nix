{
  nixos.profiles.base =
    { pkgs, ... }:
    {
      services.udev.packages = [ pkgs.libfido2 ];
      users.groups.plugdev = { };
      services.pcscd.enable = true;

      security.pam.u2f = {
        control = "sufficient";
        settings = {
          cue = true;
          authfile = "/etc/u2f-mappings";
          # fixed for all hosts instead of default pam://$HOSTNAME
          origin = "pam://nix-config";
          appid = "pam://nix-config";
        };
      };

      # sudo only
      security.pam.services.sudo.u2f.enable = true;
    };

  homeManager.profiles.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        yubikey-manager # ykman
        pam_u2f # pamu2fcfg, for registering keys with sudo
      ];
    };
}
