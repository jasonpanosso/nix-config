{ pkgs, lib, config, ... }:

let
  cfg = config.wayland.windowManager.sway;
in
{
  imports = [
    ./gammastep.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [ wl-clipboard ];

  wayland.windowManager.sway =
    let modifier = "Mod4"; in
    {
      enable = true;
      config = {
        modifier = modifier;
        terminal = "${pkgs.kitty}/bin/kitty";
        window = {
          border = 0;
          titlebar = false;
          hideEdgeBorders = "smart";
        };
        bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];
        focus = {
          followMouse = false;
        };
        gaps = {
          smartBorders = "on";
          smartGaps = false;
        };
        defaultWorkspace = "workspace number 4";

        keybindings =
          let
            pactl = "${pkgs.pulseaudio}/bin/pactl";
            swaylock = "${config.programs.swaylock.package}/bin/swaylock";
            playerctl = "${config.services.playerctld.package}/bin/playerctl";
            playerctld = "${config.services.playerctld.package}/bin/playerctld";
          in
          {
            "${modifier}+Space" = "exec ${pkgs.wofi}/bin/wofi --show=drun";
            "${modifier}+Return" = "exec ${cfg.config.terminal}";

            "${modifier}+Shift+q" = "kill";
            "${modifier}+Shift+r" = "reload";
            "${modifier}+r" = "mode resize";

            "${modifier}+Shift+f" = "floating toggle";
            "${modifier}+f" = "fullscreen toggle";
            "${modifier}+a" = "focus parent";

            "${modifier}+t" = "layout toggle tabbed split";
            "${modifier}+s" = "layout split";
            "${modifier}+v" = "layout splitv";


            "${modifier}+${cfg.config.left}" = "focus left";
            "${modifier}+${cfg.config.down}" = "focus down";
            "${modifier}+${cfg.config.up}" = "focus up";
            "${modifier}+${cfg.config.right}" = "focus right";

            "${modifier}+Left" = "focus left";
            "${modifier}+Down" = "focus down";
            "${modifier}+Up" = "focus up";
            "${modifier}+Right" = "focus right";

            "${modifier}+Shift+${cfg.config.left}" = "move left";
            "${modifier}+Shift+${cfg.config.down}" = "move down";
            "${modifier}+Shift+${cfg.config.up}" = "move up";
            "${modifier}+Shift+${cfg.config.right}" = "move right";

            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Down" = "move down";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Right" = "move right";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";
            "${modifier}+0" = "workspace number 10";

            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";
            "${modifier}+Shift+0" = "move container to workspace number 10";

            # Brightness (only works if lightd is installed)
            "XF86MonBrightnessUp" = "exec light -A 10";
            "XF86MonBrightnessDown" = "exec light -U 10";

            # Volume
            "XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +5%";
            "XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -5%";
            "XF86AudioMute" = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioMicMute" = "exec ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle";

            # Screenshotting
            # "Print" = "exec,${grimblast} --notify --freeze copy output";
            # "Shift+Print" = "exec ${grimblast} --notify --freeze copy area";
          } //
          # Media control
          (lib.optionals config.services.playerctld.enable {
            "XF86AudioNext" = "exec ${playerctl} next";
            "XF86AudioPrev" = "exec ${playerctl} previous";
            "XF86AudioPlay" = "exec ${playerctl} play-pause";
            "XF86AudioStop" = "exec ${playerctl} stop";
            "ALT+XF86AudioNext" = "exec ${playerctld} shift";
            "ALT+XF86AudioPrev" = "exec ${playerctld} unshift";
            "ALT+XF86AudioPlay" = "exec systemctl --user restart playerctld";
          }) //
          # Screen lock
          (lib.optionals config.programs.swaylock.enable {
            "XF86Launch5" = "exec ${swaylock} -S --grace 2";
            "XF86Launch4" = "exec ${swaylock} -S --grace 2";
            "${modifier}+l" = "exec ${swaylock} -S --grace 2";
          });
      };
    };

  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.sway.default = [ "wlr" "gtk" ];
  };
}
