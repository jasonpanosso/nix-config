{ config, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      moreutils # sponge for hacky resurrect fix
      tmux-sessionizer
    ];

  home.file = {
    # setup tmux-sessionizer config
    ".config/tms/config.toml".text = /* toml */ ''
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
        plugin = tmuxPlugins.tmux-nova;
        extraConfig = /* sh */ ''
          set -g @nova-nerdfonts true
          set -g @nova-nerdfonts-left 
          set -g @nova-nerdfonts-right 

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
            /* sh */ ''
            set -g @resurrect-capture-pane-contents 'on'
            set -g @resurrect-processes '${resurrectProcesses}'
            resurrect_dir="${config.home.homeDirectory}/.tmux/resurrect"
            set -g @resurrect-dir $resurrect_dir

            # cursed fix for .nix-profile, and how nix wraps programs
            set -g @resurrect-hook-post-save-all "target=\$(readlink -f \$resurrect_dir/last); if [[ -n \$target && -f \$target ]]; then sed \"s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/\$USER/bin/||g; s|/home/\$USER/.nix-profile/bin/||g\" \$target | sponge \$target; else echo 'Error: Target file is not valid.' >&2; fi"
          '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = /* sh */ ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5'
        '';
      }
    ];

    extraConfig = /* sh */ ''
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

      set -s copy-command 'wl-copy -p'
      set -s set-clipboard on

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection

      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi Escape send-keys -X cancel

      # bind p run "wl-paste -n | tmux load-buffer - ; tmux paste-buffer"
    '';
  };
}
