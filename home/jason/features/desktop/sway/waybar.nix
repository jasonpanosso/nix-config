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
        height = 30;

        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];

        modules-center = [ ];

        modules-right = [
          "network"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "pulseaudio"
          "tray"
          "clock#date"
          "clock#time"
        ];

        battery = {
          interval = 10;
          states = { warning = 30; critical = 15; };
          format = "{icon} {capacity}%"; # Icon: bolt
          format-discharging = "{icon} {capacity}%";
          format-icons = [
            "" # Icon: battery-empty
            "" # Icon: battery-quarty
            "" # Icon: battery-half
            "" # Icon: battery-three-quarters
            "" # Icon: battery-full
          ];
          "tooltip" = true;
        };

        "clock#time" = {
          interval = 1;
          format = "{:%H:%M}";
          tooltip = false;
        };

        "clock#date" = {
          interval = 10;
          format = " {:%b%e %Y}"; # Icon: calendar-alt
          tooltip-format = "{:%B%e %Y}";
        };

        cpu = {
          interval = 5;
          format = "󰇺 {usage}%"; # Icon: engine
          states = {
            warning = 70;
            critical = 90;
          };
        };

        memory = {
          interval = 5;
          format = " {}%"; # Icon: memory
          states = {
            warning = 70;
            critical = 90;
          };
        };

        network = {
          interval = 5;
          format-wifi = " {essid} ({signalStrength}%)"; # Icon: wifi
          format-ethernet = "󰈀 {ifname}: {ipaddr}/{cidr}"; # Icon: ethernet
          format-disconnected = "⚠ Disconnected"; # Icon: warning
          tooltip-format = "{ifname}: {ipaddr}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "  0%";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            portable = "";
            default = [ "" "" "" ];
          };
          on-click = pavucontrol;
        };

        "sway/mode" = {
          format = "<span style=\"italic\"> {}</span>"; # Icon: expand-arrows-alt
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
          format = "{icon} {temperatureC}°C";
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
      @keyframes blink-warning {
          70% {
              color: white;
          }

          to {
              color: white;
              background-color: orange;
          }
      }

      @keyframes blink-critical {
          70% {
            color: white;
          }

          to {
              color: white;
              background-color: red;
          }
      }


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
          background: #323232;
          color: white;
          font-family: Iosevka Nerd Font Propo, Noto Sans, sans-serif;
          font-size: 16px;
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

      #battery.warning {
          color: orange;
      }

      #battery.critical {
          color: red;
      }

      #battery.warning.discharging {
          animation-name: blink-warning;
          animation-duration: 3s;
      }

      #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #clock {
          font-weight: bold;
      }

      #cpu {
        /* No styles */
      }

      #cpu.warning {
          color: orange;
      }

      #cpu.critical {
          color: red;
      }

      #memory {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #memory.warning {
          color: orange;
      }

      #memory.critical {
          color: red;
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #mode {
          background: #64727D;
          border-top: 2px solid white;
          /* To compensate for the top border and still have vertical centering */
          padding-bottom: 2px;
      }

      #network {
          /* No styles */
      }

      #network.disconnected {
          color: orange;
      }

      #pulseaudio {
          /* No styles */
      }

      #pulseaudio.muted {
          /* No styles */
      }

      #temperature {
          /* No styles */
      }

      #temperature.critical {
          color: red;
      }

      #tray {
          /* No styles */
      }

      #workspaces button {
          border-top: 2px solid transparent;
          /* To compensate for the top border and still have vertical centering */
          padding-bottom: 2px;
          padding-left: 10px;
          padding-right: 10px;
          color: #888888;
      }

      #workspaces button.focused {
          border-color: #4c7899;
          color: white;
          background-color: #285577;
      }

      #workspaces button.urgent {
          border-color: #c9545d;
          color: #c9545d;
      }
    '';
  };
}
