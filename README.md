# nix-config

personal nix config

## usage

- switch system and home: `nh os switch` (home-manager runs as a NixOS module)
- run only nvim: `nix run github:jasonpanosso/nix-config#nvim`
- setup dev shells: `nix develop .#go` / `.#rust`
  - may need `--impure` to get toolchain/compiler version from current directory (important for rust/go)
  - for bootstrapping new nixos hosts that need nh/sops/age/git/etc: `nix develop`
- template new projects: `nix flake init -t .#LANGUAGE`
  - `nix flake init -t "$NH_FLAKE"#LANGUAGE`
  - `nix flake init -t "https://github.com/jasonpanosso/nix-config/archive/main.tar.gz"#LANGUAGE`
- build every host: `nix flake check`

## setup new host key

1. boot nixos
2. get ed25519 pub key from `/etc/ssh`
3. copy to `modules/hosts/{HOST_NAME}/ssh_host_ed25519_key.pub` and declare the host there as `hosts.{HOST_NAME}` (see `modules/meta/hosts.nix`)
4. derive age key via `ssh-to-age < PATH_TO_PUB_KEY`
5. add new key group with generated age key to `.sops.yaml`
6. `find secrets -name '*.enc.yaml' -exec sops updatekeys -y {} \;`

## yubikeys

yubikeys hold a PIV key for sops (`age-plugin-yubikey`), FIDO2 credentials for touch-to-sudo (`pam_u2f`), ssh keys (see `modules/users/jason/yubikeys.nix`), & pgp subkeys for email (see [pgp](#pgp))

copy all ssh pubkeys to a non-nixos server with `ssh-copy-yubikeys USER@HOST`

### enroll a new yubikey

1. set PIV credentials (pin & puk) and FIDO2 pin to match other yubikeys (you know these)
   ```sh
   ykman piv access change-pin
   ykman piv access change-puk
   ykman piv access change-management-key -a TDES --protect # age-plugin-yubikey doesn't support AES management keys yet
   ykman fido access change-pin
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
5. generate its ssh key; the pub key goes in the repo, the key handle into sops (handles bypass yubikey pin)
   ```sh
   serial=$(ykman list --serials | head -n1) tmp=$(mktemp -d)
   ssh-keygen -t ed25519-sk -O resident -C "jason@yubikey-$serial" -N "" -f $tmp/id
   cp $tmp/id.pub modules/users/jason/yubikeys/$serial.pub && git add modules/users/jason/yubikeys
   sops set secrets/common.enc.yaml "[\"ssh-yk-$serial\"]" "$(jq -Rs . < $tmp/id)" && rm -r $tmp
   ```
6. load the pgp subkeys from the breakglass backup (see [pgp](#pgp))
7. `nh os switch`
8. add it to github as a signing key with `gh-add-yubikeys` (skips keys already there), and re-run `ssh-copy-yubikeys` for non-nixos servers

### remove a yubikey

1. delete its recipient from `.sops.yaml` (ALL repos), then `sops updatekeys -y FILE` and `sops rotate -i FILE` for every encrypted file
2. delete its `:...` entry from `modules/users/jason/u2f_keys` (entries are in enrollment order)
3. delete its ssh key: `git rm modules/users/jason/yubikeys/SERIAL.pub && sops unset secrets/common.enc.yaml '["ssh-yk-SERIAL"]'`
4. delete its signing key from github (`gh ssh-key list`, `gh ssh-key delete ID`) and from `~/.ssh/authorized_keys` on non-nixos servers
5. `nh os switch`
6. revoke pgp subkeys if stolen

## pgp

primary key + subkeys & .rev is on the USB backups, `pgp-FPR.asc` & `FPR.rev`. YOU KNOW THE PASSPHRASE!
yubikey has sign & encrypt subkeys on them, no primary key

### setup

```sh
# before loading onto new yubikey or extending expiry:
export GNUPGHOME=$(mktemp -d) FPR=3674755D4C57C09205D0C8C3ACA1A3C9082C2044
cp -L ~/.gnupg/{scdaemon,gpg-agent}.conf $GNUPGHOME/ # pcscd + pinentry
gpg --import PATH_TO_KEY/pgp-$FPR.asc

# finish loading onto new yubikey or extending expiry, then run this:
gpgconf --kill gpg-agent && rm -rf $GNUPGHOME && unset GNUPGHOME FPR
```

### load onto a yubikey

1. set the openpgp pins to match other yubikeys: `ykman openpgp access change-pin` & `change-admin-pin` (defaults 123456 / 12345678)
2. `gpg --edit-key $FPR`, then `key 1`, `keytocard`, `1` (signature), `key 1`, `key 2`, `keytocard`, `2` (encryption), `save`
3. require touch: `ykman openpgp keys set-touch sig on` & `ykman openpgp keys set-touch dec on`

`save` swaps the temp keyring's subkeys for card stubs (and re-importing won't overwrite them), so wipe the temp `GNUPGHOME` and start over before loading another yubikey

### extend expiry

```sh
gpg --quick-set-expire $FPR 2y '*'
gpg --armor --export-secret-keys $FPR > PATH_TO_KEY/pgp-$FPR.asc
gpg --armor --export $FPR > modules/users/jason/pgp.asc
```

then `nh os switch` and update the key on github & WKD
