{ config, ... }:

let
  inherit (config) hosts;
in
{
  nixos.modules.base =
    { lib, config, ... }:
    let
      inherit (config.networking) hostName;
    in
    {
      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          PermitRootLogin = "no";
          # Automatically remove stale sockets
          StreamLocalBindUnlink = "yes";
          # Allow forwarding ports to everywhere
          GatewayPorts = "clientspecified";
        };

        hostKeys = [
          {
            path = "/etc/ssh/ssh_host_ed25519_key";
            type = "ed25519";
          }
        ];
      };

      programs.ssh = {
        # each hosts public key
        knownHosts = lib.mapAttrs (name: host: {
          publicKey = host.sshPublicKey;
          extraHostNames = lib.optional (name == hostName) "localhost";
        }) hosts;
      };

      # Passwordless sudo when SSH'ing with keys
      security.pam.sshAgentAuth = {
        enable = true;
        authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
      };
    };

  # the client half: holds keys for outgoing ssh (and agent-forwarded sudo above)
  homeManager.modules.base = {
    services.ssh-agent.enable = true;
  };
}
