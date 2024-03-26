{ config, pkgs, ... }:

let
  nova = pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "nova";
      version = "unstable-2024-02-25";
      src = pkgs.fetchFromGitHub {
        owner = "o0th";
        repo = "tmux-nova";
        rev = "c827cd1d8fac4a86766d535a47d7174715d1b18c";
        sha256 = "sha256-qpviRordzZSqVzzK56rM1uHux7Ejfq2rxmTVCHfYV54=";
      };
    };
in
{
  home.packages = with pkgs;
    [
      moreutils # sponge for hacky resurrect fix
      tmux-sessionizer
    ];

  home.file = {
    # setup tmux-sessionizer config
    ".config/tms/config.toml".text = ''
      [[search_dirs]]
      path = '${config.home.homeDirectory}/Projects'
      depth = 1
    '';
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    aggressiveResize = true;
    baseIndex = 0;
    escapeTime = 0;
    terminal = "screen-256color";
    historyLimit = 50000;
    keyMode = "emacs";

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.better-mouse-mode
      {
        plugin = nova;
        extraConfig = ''
          set -g @nova-nerdfonts true
          set -g @nova-nerdfonts-left 
          set -g @nova-nerdfonts-right 

          set -g @nova-pane-active-border-style "#76946A"
          set -g @nova-pane-border-style "#1F1F28"

          set -g @nova-status-style-bg "#16161D"
          set -g @nova-status-style-fg "#C8C093"

          set -g @nova-status-style-active-bg "#2D4F67"
          set -g @nova-status-style-active-fg "#C8C093"
          set -g @nova-status-style-double-bg "#C8C093"

          set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"
          set -g @nova-segment-whoami-colors "#43242B #C0A36E"

          set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
          set -g @nova-segment-mode-colors "#43242B #E6C384"

          set -g @nova-rows 0
          set -g @nova-segments-0-left "mode"
          set -g @nova-segments-0-right "whoami"
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig =
          let
            # ~ effectively means "process contains target name"
            resurrectProcesses = lib.concatStringsSep " " [
              "btop"
              "htop"
              "\"~nvim->nvim\""
              "\"~vi->vi\""
              "~vim"
              "\"~nix-shell->nix-shell *\""
            ];
          in
          ''
            set -g @resurrect-capture-pane-contents 'on'
            set -g @resurrect-processes '${resurrectProcesses}'
            resurrect_dir="$HOME/.tmux/resurrect"
            set -g @resurrect-dir $resurrect_dir

            # cursed fix for .nix-profile, and how nix wraps programs
            set -g @resurrect-hook-post-save-all "target=\$(readlink -f \$resurrect_dir/last); if [[ -n \$target && -f \$target ]]; then sed \"s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/\$USER/bin/||g; s|/home/\$USER/.nix-profile/bin/||g\" \$target | sponge \$target; else echo 'Error: Target file is not valid.' >&2; fi"
          '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5'
        '';
      }
    ];

    extraConfig = ''
      set -ga terminal-overrides ",xterm-256color:RGB"
      set -g repeat-time 300
      set -g detach-on-destroy off
      set -g status-interval 5
      set -g mouse on

      bind R source-file ~/.config/tmux/tmux.conf

      bind w choose-session
      bind q kill-pane
      bind c new-window

      # alternative to [ for copy mode
      bind f copy-mode
      bind 'C-f' copy-mode
      # have to bind as C-^ instead of C-6 to mimic vi C-6 last buffer bind
      bind 'C-^' last-window

      bind t display-popup -E "tms"
      bind g display-popup -E "tms switch"

      # rebinding s/v to match vim
      bind s split-window -v
      bind v split-window -h

      # move window left/right
      bind "<" swap-window -d -t -1
      bind ">" swap-window -d -t +1

      bind -r j resize-pane -D 10
      bind -r k resize-pane -U 10
      bind -r l resize-pane -R 10
      bind -r h resize-pane -L 10

      # zoom pane to fill entire window
      bind m resize-pane -Z

      # vi copy fixes
      set-window-option -g mode-keys vi
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection 'xclip -selection clipboard'

      bind -T copy-mode-vi Escape send-keys -X cancel
    '';
  };
}
