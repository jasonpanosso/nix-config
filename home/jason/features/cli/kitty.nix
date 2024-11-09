{ lib, pkgs, ... }:

{
  home.sessionVariables.TERMINAL = lib.getBin pkgs.kitty;

  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
      mode = "no-cursor";
    };

    settings = {
      scrollback_lines = 8000;
      sync_to_monitor = "no";
      disable_ligatures = "never";
      enable_audio_bell = "no";
      hide_window_decorations = "yes";
      dynamic_background_opacity = "yes";
      allow_remote_control = "yes";
      placement_strategy = "top-left";
      window_margin_width = 0;
      window_margin_height = 0;
      window_padding_width = 0;
      window_padding_height = 0;
      active_border_color = "none";
      resize_in_steps = "yes";
      allow_hyperlinks = "yes";
      shell_integration = "no-cursor";
      cursor_blink_interval = ".500";
      cursor_shape = "block";

      # background = "#${colors.base00}";
      # foreground = "#${colors.base0F}";
      # selection_background = "#${colors.base0F}";
      # selection_foreground = "#${colors.base07}";
      # url_color = "#${colors.base0C}";
      # cursor = "#${colors.base07}";
      # active_tab_background = "#${colors.base00}";
      # active_tab_foreground = "#${colors.base07}";
      # inactive_tab_background = "#${colors.base00}";
      # inactive_tab_foreground = "#${colors.base08}";
      #
      # color0 = "#${colors.base00}";
      # color1 = "#${colors.base01}";
      # color2 = "#${colors.base02}";
      # color3 = "#${colors.base03}";
      # color4 = "#${colors.base04}";
      # color5 = "#${colors.base05}";
      # color6 = "#${colors.base06}";
      # color7 = "#${colors.base07}";
      # color8 = "#${colors.base08}";
      # color9 = "#${colors.base09}";
      # color10 = "#${colors.base0A}";
      # color11 = "#${colors.base0B}";
      # color12 = "#${colors.base0C}";
      # color13 = "#${colors.base0D}";
      # color14 = "#${colors.base0E}";
      # color15 = "#${colors.base0F}";
    };

    extraConfig = /* sh */ ''
      mouse_map left click ungrabbed no-op

      # tmux clipboard bugfix
      clipboard_control write-primary write-clipboard no-append

      #: Click the link under the mouse or move the cursor
      mouse_map ctrl+left click ungrabbed mouse_handle_click selection link prompt
      mouse_map ctrl+left press ungrabbed mouse_selection normal
      mouse_map right press ungrabbed copy_to_clipboard
    '';

    keybindings = {
      "ctrl+shift+q" = "noop";
      "ctrl+shift+w" = "noop";
      "ctrl+l" = "noop";
      "ctrl+shift+l" = "noop";
    };
  };
}
