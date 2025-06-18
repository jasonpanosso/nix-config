{ pkgs, ... }:

{
  imports = [
    ./btop.nix
    ./direnv.nix
    ./eza.nix
    ./fd.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./kitty.nix
    ./kubecolor.nix
    ./kubectl.nix
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
    nodePackages_latest.npm
    nix-output-monitor
    nmap # network mapper
    p7zip # 7-zip port for unix
    pciutils # lspci
    strace # sys calls
    sysstat # sys perf monitoring tools
    go-task
    tree
    unzip
    usbutils # lsusb
    which
    xz # xz compression
    yq-go # jq for yaml
    zip
  ];
}
