{ pkgs, ... }:

{
  imports = [
    ./btop.nix
    ./direnv.nix
    ./eza.nix
    ./fd.nix
    ./font.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./kitty.nix
    ./ripgrep.nix
    ./ssh-agent.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    dnsutils # `dig` command
    docker-compose
    ethtool # query/control network device driver & hw settings
    file # determines type of a file(human readable/mime)
    glow # md viewer
    gnused # sed
    gnutar # tar
    iftop # net
    iotop # io
    ipcalc # calculates broadcast/network/host range/etc from ip & netmask
    iperf3 # network perf tool
    jq
    killall
    lazygit
    ldns # dns lookup tool - `drill` command
    lm_sensors # for `sensors` command
    lsof # list open files
    ltrace # lib calls
    mtr # my traceroute (auto refreshing traceroute)
    nix-output-monitor
    nmap # network mapper
    p7zip # 7-zip port for unix
    pciutils # lspci
    strace # sys calls
    sysstat # sys perf monitoring tools
    tree
    unzip
    usbutils # lsusb
    which
    xz # xz compression
    yq-go # jq for yaml
    zip
  ];
}
