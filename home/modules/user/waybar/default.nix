{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        modules-left = [
          "custom/nixos"
          "niri/workspaces"
          "mpris"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "cpu"
          "custom/gpu"
          "memory"
          "network"
          "tray"
        ];
        "custom/nixos" = {
          format = "󱄅";
          tooltip = false;
        };
        "niri/workspaces" = {
          on-click = "activate";
        };
        "mpris" = {
          format = "{player_icon} {title} - {artist}";
          format-paused = "{status_icon} {title} - {artist}";
          max-length = 60;
          player-icons = {
            default = "▶";
            mpv = "🎵";
          };
          status-icons = {
            paused = "⏸";
          };
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 muted";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "pavucontrol";
        };
        "cpu" = {
          format = " {usage}%";
          interval = 2;
        };
        "custom/gpu" = {
          format = " {}%";
          exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
          interval = 2;
          tooltip = false;
        };
        "memory" = {
          format = " {used:0.1f}G";
          interval = 2;
        };
        "network" = {
          format-ethernet = "󰈀 {ifname}";
          format-disconnected = "󰈀 disconnected";
          tooltip-format = "{ipaddr}";
        };
        "clock" = {
          format = " {:%A, %B %d - %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        "tray" = {
          spacing = 10;
        };
      };
    };

    style = ''
      @import "/home/killiam/.config/waybar/colors.css";
      * {
        font-family: "Maple Mono NF";
        font-size: 13px;
        border: none;
        border-radius: 0;
        min-height: 0;
      }
      window#waybar {
        background-color: alpha(@background, 0.85);
        color: @on_background;
      }
      #workspaces button {
        padding: 0 5px;
        color: @outline;
      }
      #workspaces button.active {
        color: @on_background;
      }
      #clock, #cpu, #custom-gpu, #memory,
      #network, #pulseaudio, #tray,
      #mpris, #custom-nixos {
        padding: 0 10px;
        color: @on_background;
      }
      #custom-nixos {
        color: @primary;
        font-size: 16px;
      }
    '';
  };

  home.file.".config/waybar/hyprland-config".text = builtins.toJSON {
    layer = "top";
    position = "top";
    height = 30;
    spacing = 4;
    modules-left = [
      "custom/nixos"
      "hyprland/workspaces"
      "mpris"
    ];
    modules-center = [ "clock" ];
    modules-right = [
      "pulseaudio"
      "cpu"
      "custom/gpu"
      "memory"
      "network"
      "tray"
    ];
    "custom/nixos" = {
      format = "󱄅";
      tooltip = false;
    };
    "hyprland/workspaces" = {
      on-click = "activate";
      format = "{id}";
      persistent-workspaces = {
        "*" = 4;
      };
    };
    "mpris" = {
      format = "{player_icon} {title} - {artist}";
      format-paused = "{status_icon} {title} - {artist}";
      max-length = 60;
      player-icons.default = "▶";
      status-icons.paused = "⏸";
    };
    "pulseaudio" = {
      format = "{icon} {volume}%";
      format-muted = "󰝟 muted";
      format-icons.default = ["󰕿" "󰖀" "󰕾"];
      on-click = "pavucontrol";
    };
    "cpu" = { format = " {usage}%"; interval = 2; };
    "custom/gpu" = {
      format = " {}%";
      exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
      interval = 2;
      tooltip = false;
    };
    "memory" = { format = " {used:0.1f}G"; interval = 2; };
    "network" = {
      format-ethernet = "󰈀 {ifname}";
      format-disconnected = "󰈀 disconnected";
      tooltip-format = "{ipaddr}";
    };
    "clock" = {
      format = " {:%A, %B %d - %H:%M}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };
    "tray" = { spacing = 10; };
  };
}