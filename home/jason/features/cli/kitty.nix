{ ... }:

{
  home.sessionVariables.TERMINAL = "/usr/bin/kitty";

  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
      mode = "no-cursor";
    };

    settings = {
      font_family = "IosevkaTerm Nerd Font";
      bold_font = "IosevkaTerm Nerd Font";
      italic_font = "IosevkaTerm Nerd Font, Regular Italic";
      bold_italic_font = "IosevkaTerm Nerd Font, Semibold Italic";
      scrollback_lines = 8000;
      sync_to_monitor = "no";
      disable_ligatures = "never";
      enable_audio_bell = "no";
      hide_window_decorations = "yes";
      background_opacity = 1;
      dynamic_background_opacity = "yes";
      allow_remote_control = "yes";
      placement_strategy = "center";
      window_padding_width = 0;
      window_padding_height = 0;
      font_size = 17;
      active_border_color = "none";
      resize_in_steps = "yes";
      allow_hyperlinks = "yes";
      shell_integration = "no-cursor";
      cursor_blink_interval = ".500";
      cursor_shape = "block";
    };

    extraConfig = ''
      mouse_map left click ungrabbed no-op

      # tmux clipboard bugfix
      clipboard_control write-primary write-clipboard no-append

      #: Click the link under the mouse or move the cursor
      mouse_map ctrl+left click ungrabbed mouse_handle_click selection link prompt

      mouse_map ctrl+left press ungrabbed mouse_selection normal

      mouse_map right press ungrabbed copy_to_clipboard

      # Kanagawa colors
      background #1F1F28
      foreground #DCD7BA
      selection_background #2D4F67
      selection_foreground #C8C093
      url_color #72A7BC
      cursor #C8C093
      active_tab_background #1F1F28
      active_tab_foreground #C8C093
      inactive_tab_background  #1F1F28
      inactive_tab_foreground #727169
      # tab_bar_background #15161E
      color0 #16161D
      color1 #C34043
      color2 #76946A
      color3 #C0A36E
      color4 #7E9CD8
      color5 #957FB8
      color6 #6A9589
      color7 #C8C093
      color8  #727169
      color9  #E82424
      color10 #98BB6C
      color11 #E6C384
      color12 #7FB4CA
      color13 #938AA9
      color14 #7AA89F
      color15 #DCD7BA
      color16 #FFA066
      color17 #FF5D62
    '';

    keybindings = {
      "ctrl+shift+q" = "noop";
      "ctrl+shift+w" = "noop";
      "ctrl+l" = "noop";
      "ctrl+shift+l" = "noop";
    };
  };
}
