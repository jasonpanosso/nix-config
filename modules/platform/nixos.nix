{
  nixos.profiles.base =
    { lib, pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.git ];

      services.openssh.settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        # Automatically remove stale sockets
        StreamLocalBindUnlink = "yes";
        # Allow forwarding ports to everywhere
        GatewayPorts = "clientspecified";
      };

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

      i18n = {
        defaultLocale = lib.mkDefault "en_US.UTF-8";
        supportedLocales = lib.mkDefault [
          "en_US.UTF-8/UTF-8"
        ];
      };
      time.timeZone = lib.mkDefault "America/Detroit";
    };
}
