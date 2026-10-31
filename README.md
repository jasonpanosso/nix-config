# nix-config

personal nix config

## usage

- switch system (nixos): `nh os switch`
- switch home: `nh home switch` (`jason@<hostname>`, defined next to the host)
- run only nvim: `nix run github:jasonpanosso/nix-config#nvim`
- setup dev shells: `nix develop .#go` / `.#rust`
  - for bootstrapping new nixos hosts that need nh/sops/age/git/etc: `nix develop`
- template new projects: `nix flake init -t .#go` (also `rust`, `typescript`)
- build every host: `nix flake check`

## setup new host key

1. boot nixos
2. get ed25519 pub key from `/etc/ssh`
3. copy to `modules/hosts/{HOST_NAME}/ssh_host_ed25519_key.pub`
4. derive age key via `ssh-to-age < PATH_TO_PUB_KEY`
5. add new key group with generated age key to `.sops.yaml`
6. `find secrets -name '*.enc.yaml' -exec sops updatekeys -y {} \;`
