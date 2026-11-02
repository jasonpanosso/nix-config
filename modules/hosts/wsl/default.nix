# NixOS under WSL: no bootloader, no desktop session (foot runs via WSLg), Windows interop
{ inputs, config, ... }:

{
  hosts.wsl = {
    users = [ "jason" ];
    sshPublicKey = builtins.readFile ./ssh_host_ed25519_key.pub;

    module = {
      imports = [ inputs.nixos-wsl.nixosModules.default ];

      wsl = {
        enable = true;
        defaultUser = "jason";
        # stop windows from shadowing linux binaries
        interop.includePath = false;
        # bind from windows: `usbipd bind --busid <id>`
        usbip = {
          enable = true;
          # yubikey port
          autoAttach = [ "1-7" ];
        };
      };

      # WSL's kernel builds usbip and usb hid as modules and nothing loads them
      systemd.services."usbip-auto-attach@".serviceConfig.ExecStartPre =
        "/sbin/modprobe -a vhci-hcd usbhid";

      system.stateVersion = "26.05";

      home-manager.sharedModules = [
        config.homeManager.profiles.wsl
        config.homeManager.profiles.graphical
      ];
    };
  };

  homeManager.profiles.wsl =
    { pkgs, ... }:
    {
      # stand-in for wslu's wslview (dropped from nixpkgs)
      # need for nvim's gx/:Open, gh, etc.
      home.packages = [
        (pkgs.writeShellScriptBin "wslview" ''
          target="$1"
          case "$target" in
            *://*) ;;
            *) [ -e "$target" ] && target=$(/sbin/wslpath -w "$target") ;;
          esac
          # explorer.exe exits 1 even on success
          /mnt/c/Windows/explorer.exe "$target" || true
        '')
      ];
    };
}
