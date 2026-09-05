{ pkgs, config, ... }: let
  wallpaperScript = pkgs.writeShellScriptBin "niri-random-wallpaper" ''
    pkill -f swaybg 2>/dev/null || true
    walp=$(find "$HOME/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
    [ -n "$walp" ] && echo "$walp" > ~/.cache/current-wallpaper
    [ -n "$walp" ] && ${pkgs.swaybg}/bin/swaybg -m "fill" -i "$walp" &
    [ -n "$walp" ] && ${pkgs.matugen}/bin/matugen image "$walp" --mode dark
    [ -n "$walp" ] && ${pkgs.pywal}/bin/wal -i "$walp" -n -q
    [ -n "$walp" ] && bash ~/.config/matugen/templates/btop/gen-pywal-btop.sh
    [ -n "$walp" ] && bash ~/.config/matugen/templates/cava/gen-pywal-cava.sh
    [ -n "$walp" ] && pkill waybar; ${pkgs.waybar}/bin/waybar &
    [ -n "$walp" ] && pkill -USR1 cava 2>/dev/null || true
    [ -n "$walp" ] && pkill -USR1 kitty 2>/dev/null || true
  '';

  selectWallpaper = pkgs.writeShellScriptBin "niri-select-wallpaper" ''
    walp=$(find "$HOME/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.png" \) | ${pkgs.fuzzel}/bin/fuzzel --dmenu)
    [ -n "$walp" ] && pkill -f swaybg 2>/dev/null || true
    [ -n "$walp" ] && echo "$walp" > ~/.cache/current-wallpaper
    [ -n "$walp" ] && ${pkgs.swaybg}/bin/swaybg -m "fill" -i "$walp" &
    [ -n "$walp" ] && ${pkgs.matugen}/bin/matugen image "$walp" --mode dark
    [ -n "$walp" ] && ${pkgs.pywal}/bin/wal -i "$walp" -n -q
    [ -n "$walp" ] && bash ~/.config/matugen/templates/btop/gen-pywal-btop.sh
    [ -n "$walp" ] && bash ~/.config/matugen/templates/cava/gen-pywal-cava.sh
    [ -n "$walp" ] && pkill waybar; ${pkgs.waybar}/bin/waybar &
    [ -n "$walp" ] && pkill -USR1 cava 2>/dev/null || true
    [ -n "$walp" ] && pkill -USR1 kitty 2>/dev/null || true
  '';

  screenshotScript = pkgs.writeShellScriptBin "niri-screenshot" ''
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | tee /home/killiam/Pictures/Screenshots/$(date +%s).png | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png
  '';

  cliphistScript = pkgs.writeShellScriptBin "niri-cliphist-pick" ''
    cliphist list | ${pkgs.fuzzel}/bin/fuzzel --dmenu | cliphist decode | wl-copy
  '';

  toggleWaybarNiri = pkgs.writeShellScriptBin "niri-toggle-waybar" ''
    if pgrep -f "bin/waybar" > /dev/null; then
      pkill -f "bin/waybar"
    else
      ${pkgs.waybar}/bin/waybar &
    fi
  '';
in {
  home.packages = [ wallpaperScript selectWallpaper screenshotScript cliphistScript toggleWaybarNiri ];

  programs.niri = {
    settings = {
      outputs."DP-4" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 179.998;
        };
      };

      spawn-at-startup = [
        { command = ["dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"]; }
        { command = ["bash" "-c" "walp=$(cat ~/.cache/current-wallpaper 2>/dev/null); [ -n \"$walp\" ] && ${pkgs.swaybg}/bin/swaybg -m fill -i \"$walp\" || ${wallpaperScript}/bin/niri-random-wallpaper"]; }
        { command = ["gsettings" "set" "org.gnome.desktop.interface" "gtk-theme" "adw-gtk3-dark"]; }
        { command = ["gsettings" "set" "org.gnome.desktop.interface" "color-scheme" "prefer-dark"]; }
        { command = ["wl-paste" "--watch" "cliphist" "store"]; }
        { command = ["waybar"]; }
      ];

      environment = {
        NIXOS_OZONE_WL = "1";
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";
        GBM_BACKEND = "nvidia-drm";
        LIBVA_DRIVER_NAME = "nvidia";
        AQ_NO_MODIFIERS = "1";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
        XCURSOR_THEME = "macOS";
        XCURSOR_SIZE = "24";
        QT_QPA_PLATFORMTHEME = "qt5ct";
        GTK_THEME = "adw-gtk3-dark";
        DISPLAY = ":0";
      };

      input = {
        keyboard = {
          xkb.layout = "us";
          repeat-delay = 250;
          repeat-rate = 35;
        };
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus.enable = true;
      };

      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;

      layout = {
        gaps = 4;
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };
        border = {
          enable = true;
          width = 2;
          active.color = "#484949b8";
          inactive.color = "#313131";
        };
        focus-ring.enable = false;
        background-color = "#00000000";
      };

      cursor = {
        theme = "macOS";
        size = 24;
      };

      binds = {
        "Mod+T".action.spawn = "kitty";
        "Mod+Return".action.spawn = "kitty";
        "Mod+W".action.spawn = "brave";
        "Mod+E".action.spawn = "thunar";
        "Mod+C".action.spawn = "/etc/profiles/per-user/killiam/bin/codium";
        "Mod+N".action.spawn = ["kitty" "-e" "nvim"];
        "Mod+D".action.spawn = "discord";
        "Mod+O".action.spawn = "obsidian";
        "Mod+P".action.spawn = "spotify";
        "Mod+period".action.spawn = "emote";
        "Mod+K".action.spawn = "krita";
        "Mod+G".action.spawn = "gnome-boxes";
        "Mod+L".action.spawn = "wlogout";
        "Mod+A".action.spawn = "seanime";
        "Mod+Shift+Q".action.spawn = "qbittorrent";
        "Mod+S".action.spawn = ["${screenshotScript}/bin/niri-screenshot"];
        "Mod+Shift+S".action.spawn = ["bash" "-c" "f=/home/killiam/Pictures/Screenshots/$(date +%s).png && grim $f && wl-copy < $f"];
        "Mod+Space".action.spawn = "fuzzel";
        "Mod+V".action.spawn = ["${cliphistScript}/bin/niri-cliphist-pick"];
        "Mod+B".action.spawn = ["${toggleWaybarNiri}/bin/niri-toggle-waybar"];
        "Mod+Q".action.close-window = {};
        "Mod+F".action.fullscreen-window = {};
        "Mod+Alt+Space".action.toggle-window-floating = {};
        
        "Mod+Left".action.focus-column-left = {};
        "Mod+Right".action.focus-column-right = {};
        "Mod+Up".action.focus-workspace-up = {};
        "Mod+Down".action.focus-workspace-down = {};
        "Mod+WheelScrollUp" = { cooldown-ms = 150; action.focus-workspace-up = {}; };
        "Mod+WheelScrollDown" = { cooldown-ms = 150; action.focus-workspace-down = {}; };
        "Mod+Shift+Left".action.move-column-left = {};
        "Mod+Shift+Right".action.move-column-right = {};
        "Mod+Shift+Up".action.move-column-to-workspace-up = {};
        "Mod+Shift+Down".action.move-column-to-workspace-down = {};
        "Ctrl+Up".action.focus-window-up = {};
        "Ctrl+Down".action.focus-window-down = {};
        "Mod+Tab".action.toggle-overview = {};
        "Mod+Ctrl+Left".action.set-column-width = "-10%";
        "Mod+Ctrl+Right".action.set-column-width = "+10%";
        "Mod+Ctrl+Up".action.set-window-height = "+10%";
        "Mod+Ctrl+Down".action.set-window-height = "-10%";

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+0".action.focus-workspace = 10;

        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;
        "Mod+Shift+0".action.move-column-to-workspace = 10;

        "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "2%+"];
        "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "2%-"];
        "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
        "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];
        "XF86AudioNext".action.spawn = ["playerctl" "next"];
        "XF86AudioPrev".action.spawn = ["playerctl" "previous"];
        "Mod+F5".action.spawn = ["ddcutil" "setvcp" "10" "-" "5"];
        "Mod+F6".action.spawn = ["ddcutil" "setvcp" "10" "+" "5"];
      };

      window-rules = [
        {
          matches = [];
          draw-border-with-background = false;
          clip-to-geometry = true;
          geometry-corner-radius = {
            top-left = 0.0;
            top-right = 0.0;
            bottom-left = 0.0;
            bottom-right = 0.0;
          };
        }
        {
          matches = [{ app-id = "kitty"; }];
          default-column-width.proportion = 1.0;
          open-maximized = true;
        }
        {
          matches = [{ app-id = "codium"; }];
          opacity = 0.95;
        }
      ];
    };
  };
}