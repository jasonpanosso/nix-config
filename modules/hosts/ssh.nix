{ config, ... }:

let
  inherit (config) hosts;
in
{
  nixos.profiles.base =
    { lib, config, ... }:
    let
      inherit (config.networking) hostName;
    in
    {
      # sshd generates the host key on first boot; sops decrypts with it
      services.openssh = {
        enable = true;
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
    };
}
