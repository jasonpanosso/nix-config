# nix-config

personal nix config

for host keys:

1. boot nixos
2. get ed25519 pub key from `/etc/ssh`
3. copy to `hosts/{HOST_NAME}/ssh_host_ed25519_key.pub`
4. derive age key via `ssh-to-age < PATH_TO_PUB_KEY`
5. add new key group with generated age key to `.sops.yaml`
6. `find . -name '*.enc.yaml' -exec sops updatekeys -y {} \;`
