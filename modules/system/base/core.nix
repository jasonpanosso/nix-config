{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.git ];

      hardware.enableRedistributableFirmware = true;

      # speed up boot time
      systemd.services.NetworkManager-wait-online.enable = false;
      systemd.network.wait-online.enable = false;

      boot.initrd.systemd.enable = true;

      # Increase open file limit for sudoers
      security.pam.loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];
    };
}
