{ pkgs, ... }:

let
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
in
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
    });
    settings = {
      primary = {
        mode = "dock";
        layer = "top";
        position = "top";
        height = 34;

        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];

        modules-right = [
          "network"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "pulseaudio"
          "clock"
          # "tray"
        ];

        battery = {
          interval = 10;
          states = { warning = 30; critical = 15; };
          format = " {icon}   {capacity}%"; # Icon: bolt
          format-discharging = "{icon}   {capacity}%";
          format-icons = [
            "" # Icon: battery-empty
            "" # Icon: battery-quarty
            "" # Icon: battery-half
            "" # Icon: battery-three-quarters
            "" # Icon: battery-full
          ];
          "tooltip" = true;
        };

        clock = {
          interval = 1;
          format = "󰃰   {:%b %d %H:%M}"; # Icon: calendar/clock
          tooltip-format = "{:%B %e %Y}";
        };

        cpu = {
          interval = 5;
          format = "󰇺   {usage}%"; # Icon: engine
          states = {
            warning = 70;
            critical = 90;
          };
        };

        memory = {
          interval = 5;
          format = "   {}%"; # Icon: memory
          states = {
            warning = 70;
            critical = 90;
          };
        };

        network = {
          interval = 5;
          format-wifi = "   Connected"; # Icon: wifi
          format-ethernet = "󰈀  {ipaddr}/{cidr}"; # Icon: ethernet
          format-disconnected = "⚠  Disconnected"; # Icon: warning
          tooltip-format = "{ifname} via {gwaddr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname}";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "   0%";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            portable = "";
            default = [ "" "" "" ];
          };
          on-click = pavucontrol;
        };

        "sway/mode" = {
          format = "<span style=\"italic\">   {}</span>"; # Icon: expand-arrows-alt
          tooltip = false;
        };

        "sway/workspaces" = {
          all-outputs = false;
          disable-scroll = true;
          format = "{name}";
        };

        temperature = {
          critical-threshold = 80;
          interval = 5;
          format = "{icon}  {temperatureC}°C";
          format-icons = [
            "" # Icon = temperature-empty
            "" # Icon = temperature-quarter
            "" # Icon = temperature-half
            "" # Icon = temperature-three-quarters
            "" # Icon = temperature-full
          ];
          tooltip = true;
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };
    style = /* css */ ''
      /* -----------------------------------------------------------------------------
       * Base styles
       * -------------------------------------------------------------------------- */

      /* Reset all styles */
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
      }

      /* The whole bar */
      #waybar {
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      #waybar.hidden {
        opacity: 0.2;
      }

      /* Each module */
      #battery,
      #clock,
      #cpu,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #tray {
        padding-left: 10px;
        padding-right: 10px;
      }


      /* -----------------------------------------------------------------------------
       * Module styles
       * -------------------------------------------------------------------------- */

      #battery {
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #battery.warning.discharging {
        animation-name: blink-warning;
        animation-duration: 3s;
      }

      #battery.critical.discharging {
        animation-name: blink-critical;
        animation-duration: 2s;
      }

      #memory {
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #memory.critical {
        animation-name: blink-critical;
        animation-duration: 2s;
      }

      #workspaces button {
        padding: 0 5px;
        border-radius: 5px;
      }

      #workspaces button.focused {
        border-bottom: none;
      }

      tooltip {
        border-radius: 5px;
      }

      widget > * {
        margin-top: 6px;
        margin-bottom: 6px;
      }

      .modules-left > widget > * {
        margin-left: 12px;
        margin-right: 12px;
      }

      .modules-left > widget:first-child > * {
        margin-left: 6px;
      }

      .modules-left > widget:last-child > * {
        margin-right: 18px;
      }

      .modules-right > widget > * {
        padding: 0 12px;
        margin-left: 0;
        margin-right: 0;
      }

      .modules-right > widget:first-child > * {
        border-radius: 5px 0 0 5px;
      }

      .modules-right > widget:last-child > * {
        border-radius: 0 5px 5px 0;
        margin-right: 6px;
      }
    '';
  };
}
