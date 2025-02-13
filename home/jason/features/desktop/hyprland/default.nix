{ pkgs, config, ... }:

{
  imports = [
    ./mako.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    libnotify
  ];

  wayland.windowManager.hyprland =
    let
      leftMonitor = "Ancor Communications Inc VG248 71LB06600000";
      rightMonitor = "ASUSTek COMPUTER INC VG259QM M1LMQS046469";
    in
    {
      enable = true;
      systemd.enable = false;
      xwayland.enable = false;

      settings = {
        "$mainMod" = "SUPER";

        general = {
          gaps_out = 0;
        };

        cursor = {
          no_hardware_cursors = true;
        };

        input = {
          accel_profile = "flat";
          sensitivity = "-0.2";
        };

        monitor = [
          "desc:${leftMonitor}, highrr, 0x0, 1"
          "desc:${rightMonitor}, highrr, 1920x0, 1"
          ", preferred, auto, 1"
        ];

        workspace = [
          "1, monitor:desc:${leftMonitor}"
          "2, monitor:desc:${leftMonitor}"
          "3, monitor:desc:${leftMonitor}, default:true"

          "4, monitor:desc:${rightMonitor}, default:true"
          "5, monitor:desc:${rightMonitor}"
          "6, monitor:desc:${rightMonitor}"

          # smart gaps
          "f[1], gapsout:0, gapsin:0"
          "w[tg1], gapsout:0, gapsin:0"
          "w[t1], gapsout:0, gapsin:0"
        ];

        # smart gaps
        windowrulev2 = [
          "bordersize 0, floating:0, onworkspace:w[t1]"
          "rounding 0, floating:0, onworkspace:w[t1]"
          "bordersize 0, floating:0, onworkspace:w[tg1]"
          "rounding 0, floating:0, onworkspace:w[tg1]"
          "bordersize 0, floating:0, onworkspace:f[1]"
          "rounding 0, floating:0, onworkspace:f[1]"
        ];

        env = [
          "WLR_NO_HARDWARE_CURSORS,1"
        ];

        animations.enabled = false;

        exec-once = [
          "waybar -c ~/.config/waybar/config 2>&1 > ~/.waybar.log"
        ];
        bind =
          let
            swaylock = "${config.programs.swaylock.package}/bin/swaylock";
            playerctld = "${config.services.playerctld.package}/bin/playerctld";
            makoctl = "${config.services.mako.package}/bin/makoctl";
          in
          [
            "$mainMod, Space, exec, ${pkgs.wofi}/bin/wofi --show=drun"
            "$mainMod, Return, exec, /usr/bin/kitty"
            "$mainMod, d, exec, ${makoctl} dismiss"

            "$mainMod SHIFT, q, killactive"
            "$mainMod SHIFT, f, togglefloating"
            "$mainMod, f, fullscreen"

            "$mainMod, h, movefocus, l"
            "$mainMod, l, movefocus, r"
            "$mainMod, k, movefocus, u"
            "$mainMod, j, movefocus, d"
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"

            "$mainMod SHIFT, h, movewindow, l"
            "$mainMod SHIFT, l, movewindow, r"
            "$mainMod SHIFT, k, movewindow, u"
            "$mainMod SHIFT, j, movewindow, d"
            "$mainMod SHIFT, left, movewindow, l"
            "$mainMod SHIFT, right, movewindow, r"
            "$mainMod SHIFT, up, movewindow, u"
            "$mainMod SHIFT, down, movewindow, d"

            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"

            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"

            "ALT, XF86AudioNext, exec, ${playerctld} shift"
            "ALT, XF86AudioPrev, exec, ${playerctld} unshift"
            "ALT, XF86AudioPlay, exec, systemctl --user restart playerctld"

            ",XF86Launch5, exec, ${swaylock} -S --grace 2"
            ",XF86Launch4, exec, ${swaylock} -S --grace 2"
            "$mainMod, escape, exec, ${swaylock} -S --grace 2"
          ];

        # binds that work when screen is locked
        bindel =
          let
            pactl = "${pkgs.pulseaudio}/bin/pactl";
            playerctl = "${config.services.playerctld.package}/bin/playerctl";
          in
          [
            ",XF86AudioRaiseVolume, exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
            ",XF86AudioLowerVolume, exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
            ",XF86AudioMute, exec, ${pactl} set-sink-mute @DEFAULT_SINK@ toggle"
            ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
            ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
            ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"

            # Brightness (only works if lightd is installed)
            ",XF86MonBrightnessUp, exec, light -A 10"
            ",XF86MonBrightnessDown, exec, light -U 10"

            ",XF86AudioNext, exec, ${playerctl} next"
            ",XF86AudioPrev, exec, ${playerctl} previous"
            ",XF86AudioPlay, exec, ${playerctl} play-pause"
            ",XF86AudioStop, exec, ${playerctl} stop"
          ];
      };
    };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "wlr" "gtk" ];
  };
}
