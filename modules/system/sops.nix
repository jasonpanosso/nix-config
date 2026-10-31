{ inputs, ... }:

{
  nixos.modules.base =
    { config, ... }:
    let
      isEd25519 = k: k.type == "ed25519";
      getKeyPath = k: k.path;
      keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
    in
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      sops = {
        age.sshKeyPaths = map getKeyPath keys;
        # one default for every secret, rooted at the flake instead of a relative path;
        # builtins.path copies only this file, so the system doesn't depend on the whole repo
        defaultSopsFile = builtins.path {
          path = "${inputs.self}/secrets/common.enc.yaml";
          name = "common.enc.yaml";
        };
      };
    };
}
