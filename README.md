# nix-config

personal nix config

## usage

- switch system and home: `nh os switch` (home-manager runs as a NixOS module)
- run only nvim: `nix run github:jasonpanosso/nix-config#nvim`
- setup dev shells: `nix develop .#go` / `.#rust`
  - for bootstrapping new nixos hosts that need nh/sops/age/git/etc: `nix develop`
- template new projects: `nix flake init -t .#LANGUAGE`
- build every host: `nix flake check`

## setup new host key

1. boot nixos
2. get ed25519 pub key from `/etc/ssh`
3. copy to `modules/hosts/{HOST_NAME}/ssh_host_ed25519_key.pub` and declare the host there as `hosts.{HOST_NAME}` (see `modules/meta/hosts.nix`)
4. derive age key via `ssh-to-age < PATH_TO_PUB_KEY`
5. add new key group with generated age key to `.sops.yaml`
6. `find secrets -name '*.enc.yaml' -exec sops updatekeys -y {} \;`

## yubikeys

yubikeys hold a PIV key for sops (`age-plugin-yubikey`) & have FIDO2 set up for touch-to-sudo (`pam_u2f`)

### enroll a new yubikey

1. set PIV credentials (pin & puk) to match other yubikeys (you know these)
   ```sh
   ykman piv access change-pin
   ykman piv access change-puk
   ykman piv access change-management-key -a TDES --protect # age-plugin-yubikey doesn't support AES management keys yet
   ```
2. generate its sops key and copy the printed `age1yubikey1...` recipient
   ```sh
   age-plugin-yubikey --generate --name jason --pin-policy once --touch-policy cached
   ```
3. add the recipient to `.sops.yaml` (IN ALL OF YOUR REPOS), then re-encrypt all encrypted files with a yubikey that's already enrolled: `sops updatekeys -y FILE`
4. register it for sudo, appending to the same line in `modules/users/jason/u2f_keys`
   ```sh
   echo "$(cat modules/users/jason/u2f_keys)$(pamu2fcfg -n -o pam://nix-config -i pam://nix-config)" > modules/users/jason/u2f_keys
   ```
5. `nh os switch`

### remove a yubikey

1. delete its recipient from `.sops.yaml` (ALL repos), then `sops updatekeys -y FILE` and `sops rotate -i FILE` for every encrypted file
2. delete its `:...` entry from `modules/users/jason/u2f_keys` (entries are in enrollment order)
3. `nh os switch`
