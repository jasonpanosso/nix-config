{
  homeManager.modules.base =
    { pkgs, ... }:

    {
      home.packages = with pkgs; [
        claude-code
        dnsutils # `dig` command
        docker-compose
        file # determines type of a file(human readable/mime)
        glow # md viewer
        gnused # sed
        gnutar # tar
        iftop # net
        ipcalc # calculates broadcast/network/host range/etc from ip & netmask
        iperf3 # network perf tool
        jq
        killall
        ldns # dns lookup tool - `drill` command
        lsof # list open files
        mtr # my traceroute (auto refreshing traceroute)
        nix-output-monitor
        nmap # network mapper
        p7zip # 7-zip port for unix
        pciutils # lspci
        pnpm
        sops
        go-task
        tree
        unzip
        usbutils # lsusb
        which
        xz # xz compression
        yq-go # jq for yaml
        zip
      ];
    };
}
