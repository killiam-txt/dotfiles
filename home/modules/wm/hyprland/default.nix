{pkgs, lib, ...}: let
  wallpaperScript = pkgs.writeShellScriptBin "hypr-random-wallpaper" ''
    pkill -f swaybg 2>/dev/null || true
    walp=$(find "$HOME/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
    [ -n "$walp" ] && echo "$walp" > ~/.cache/current-wallpaper
    [ -n "$walp" ] && ${pkgs.swaybg}/bin/swaybg -m "fill" -i "$walp" &
    [ -n "$walp" ] && ${pkgs.matugen}/bin/matugen image "$walp" --mode dark
    [ -n "$walp" ] && bash ~/.config/matugen/templates/hyprland/apply-colors.sh
    [ -n "$walp" ] && ${pkgs.pywal}/bin/wal -i "$walp" -n -q
    [ -n "$walp" ] && bash ~/.config/matugen/templates/btop/gen-pywal-btop.sh
    [ -n "$walp" ] && bash ~/.config/matugen/templates/cava/gen-pywal-cava.sh
    [ -n "$walp" ] && pkill waybar; ${pkgs.waybar}/bin/waybar --config ~/.config/waybar/hyprland-config &
    [ -n "$walp" ] && pkill -USR1 cava 2>/dev/null || true
    [ -n "$walp" ] && pkill -USR1 kitty 2>/dev/null || true
  '';

  selectWallpaper = pkgs.writeShellScriptBin "hypr-select-wallpaper" ''
    walp=$(find "$HOME/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.png" \) | ${pkgs.fuzzel}/bin/fuzzel --dmenu)
    [ -n "$walp" ] && pkill -f swaybg 2>/dev/null || true
    [ -n "$walp" ] && echo "$walp" > ~/.cache/current-wallpaper
    [ -n "$walp" ] && ${pkgs.swaybg}/bin/swaybg -m "fill" -i "$walp" &
    [ -n "$walp" ] && ${pkgs.matugen}/bin/matugen image "$walp" --mode dark
    [ -n "$walp" ] && bash ~/.config/matugen/templates/hyprland/apply-colors.sh
    [ -n "$walp" ] && ${pkgs.pywal}/bin/wal -i "$walp" -n -q
    [ -n "$walp" ] && bash ~/.config/matugen/templates/btop/gen-pywal-btop.sh
    [ -n "$walp" ] && bash ~/.config/matugen/templates/cava/gen-pywal-cava.sh
    [ -n "$walp" ] && pkill waybar; ${pkgs.waybar}/bin/waybar --config ~/.config/waybar/hyprland-config &
    [ -n "$walp" ] && pkill -USR1 cava 2>/dev/null || true
    [ -n "$walp" ] && pkill -USR1 kitty 2>/dev/null || true
  '';

  screenshotScript = pkgs.writeShellScriptBin "screenshot-area" ''
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | tee /home/killiam/Pictures/Screenshots/$(date +%s).png | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png
  '';

  cliphistScript = pkgs.writeShellScriptBin "cliphist-pick" ''
    cliphist list | ${pkgs.fuzzel}/bin/fuzzel --dmenu | cliphist decode | wl-copy
  '';

  toggleWaybar = pkgs.writeShellScriptBin "toggle-waybar-hyprland" ''
    if pgrep -f "bin/waybar" > /dev/null; then
      pkill -f "bin/waybar"
    else
      ${pkgs.waybar}/bin/waybar --config ~/.config/waybar/hyprland-config &
    fi
  '';
in {
  home.packages = [wallpaperScript selectWallpaper screenshotScript cliphistScript toggleWaybar];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    extraConfig = ''
      -- monitor
      hl.monitor({
        output = "DP-4",
        mode = "1920x1080@180",
        position = "auto",
        scale = 1,
      })

      -- exec-once
      hl.on("hyprland.start", function()
        hl.exec_cmd("waybar --config ~/.config/waybar/hyprland-config")
        hl.exec_cmd("bash -c 'walp=$(cat ~/.cache/current-wallpaper 2>/dev/null); [ -n \"$walp\" ] && ${pkgs.swaybg}/bin/swaybg -m fill -i \"$walp\" || ${wallpaperScript}/bin/hypr-random-wallpaper'")
        hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'")
        hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
        hl.exec_cmd("wl-paste --watch cliphist store")
        hl.exec_cmd("bash ~/.config/matugen/templates/hyprland/apply-colors.sh")
      end)

      -- env
      hl.env("NIXOS_OZONE_WL", "1")
      hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
      hl.env("XDG_SESSION_TYPE", "wayland")
      hl.env("XDG_SESSION_DESKTOP", "Hyprland")
      hl.env("GBM_BACKEND", "nvidia-drm")
      hl.env("LIBVA_DRIVER_NAME", "nvidia")
      hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
      hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
      hl.env("XCURSOR_THEME", "macOS")
      hl.env("XCURSOR_SIZE", "24")
      hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
      hl.env("GTK_THEME", "adw-gtk3-dark")
      hl.env("GTK2_RC_FILES", "/dev/null")

      -- config
      hl.config({
        general = {
          gaps_in = 4,
          gaps_out = 5,
          border_size = 2,
          ["col.active_border"] = "rgba(86d6bfff)",
          ["col.inactive_border"] = "rgba(3f4945ff)",
          resize_on_border = true,
          allow_tearing = true,
        },
        decoration = {
          rounding = 0,
          active_opacity = 1.0,
          inactive_opacity = 0.95,
          dim_inactive = true,
          dim_strength = 0.025,
          blur = { enabled = false },
          shadow = { enabled = false },
        },
        animations = { enabled = true },
        input = {
          kb_layout = "us",
          numlock_by_default = true,
          repeat_delay = 250,
          repeat_rate = 35,
          follow_mouse = 1,
        },
        misc = {
          disable_hyprland_logo = true,
          disable_splash_rendering = true,
          vrr = 1,
          focus_on_activate = true,
        },
        cursor = { no_hardware_cursors = true },
      })

      -- bezier curves
      hl.curve("emphasizedDecel", { type = "bezier", points = {{0.05, 0.7}, {0.1, 1}} })
      hl.curve("emphasizedAccel", { type = "bezier", points = {{0.3, 0}, {0.8, 0.15}} })
      hl.curve("menu_decel",      { type = "bezier", points = {{0.1, 1}, {0, 1}} })
      hl.curve("menu_accel",      { type = "bezier", points = {{0.52, 0.03}, {0.72, 0.08}} })

      -- animations
      hl.animation({ leaf = "windowsIn",     enabled = true, speed = 3,   bezier = "emphasizedDecel", style = "popin 80%" })
      hl.animation({ leaf = "windowsOut",    enabled = true, speed = 2,   bezier = "emphasizedDecel", style = "popin 90%" })
      hl.animation({ leaf = "windowsMove",   enabled = true, speed = 3,   bezier = "emphasizedDecel", style = "slide" })
      hl.animation({ leaf = "border",        enabled = true, speed = 10,  bezier = "emphasizedDecel" })
      hl.animation({ leaf = "layersIn",      enabled = true, speed = 2.7, bezier = "emphasizedDecel", style = "popin 93%" })
      hl.animation({ leaf = "layersOut",     enabled = true, speed = 2.4, bezier = "menu_accel",      style = "popin 94%" })
      hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 0.5, bezier = "menu_decel" })
      hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2.7, bezier = "menu_accel" })
      hl.animation({ leaf = "workspaces",    enabled = true, speed = 7,   bezier = "menu_decel",      style = "slide" })

      -- window rules
      hl.window_rule({ match = { xwayland = true }, immediate = true })
      hl.window_rule({ match = { class = "^(codium|Codium)$" }, opacity = "0.95 0.95" })

      -- binds: apps
      hl.bind("SUPER + T",         hl.dsp.exec_cmd("kitty"))
      hl.bind("SUPER + RETURN",    hl.dsp.exec_cmd("kitty"))
      hl.bind("SUPER + W",         hl.dsp.exec_cmd("brave"))
      hl.bind("SUPER + E",         hl.dsp.exec_cmd("thunar"))
      hl.bind("SUPER + C",         hl.dsp.exec_cmd("codium"))
      hl.bind("SUPER + D",         hl.dsp.exec_cmd("discord"))
      hl.bind("SUPER + O",         hl.dsp.exec_cmd("obsidian"))
      hl.bind("SUPER + P",         hl.dsp.exec_cmd("spotify"))
      hl.bind("SUPER + period",    hl.dsp.exec_cmd("emote"))
      hl.bind("SUPER + K",         hl.dsp.exec_cmd("krita"))
      hl.bind("SUPER + G",         hl.dsp.exec_cmd("gnome-boxes"))
      hl.bind("SUPER + L",         hl.dsp.exec_cmd("wlogout"))
      hl.bind("SUPER + A",         hl.dsp.exec_cmd("seanime"))
      hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("qbittorrent"))
      hl.bind("SUPER + H",         hl.dsp.exec_cmd("heroic"))
      hl.bind("SUPER + SPACE",     hl.dsp.exec_cmd("fuzzel"))
      hl.bind("SUPER + Q",         hl.dsp.window.close())
      hl.bind("SUPER + S",         hl.dsp.exec_cmd("${screenshotScript}/bin/screenshot-area"))
      hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("${pkgs.grim}/bin/grim - | tee /home/killiam/Pictures/Screenshots/$(date +%s).png | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png"))
      hl.bind("SUPER + V",         hl.dsp.exec_cmd("${cliphistScript}/bin/cliphist-pick"))
      hl.bind("SUPER + B",         hl.dsp.exec_cmd("${toggleWaybar}/bin/toggle-waybar-hyprland"))
      hl.bind("SUPER + ALT + SPACE", hl.dsp.window.float())
      hl.bind("SUPER + F", hl.dsp.exec_cmd("hyprctl eval \"hl.dispatch(hl.dsp.window.fullscreen())\""))

      -- movefocus
      hl.bind("SUPER + ALT + Left",  hl.dsp.focus({ direction = "left" }))
      hl.bind("SUPER + ALT + Right", hl.dsp.focus({ direction = "right" }))
      hl.bind("SUPER + ALT + Up",    hl.dsp.focus({ direction = "up" }))
      hl.bind("SUPER + ALT + Down",  hl.dsp.focus({ direction = "down" }))

      -- workspace navigation
      hl.bind("SUPER + Left",  hl.dsp.exec_cmd("hyprctl dispatch \"hl.dsp.focus({workspace='r-1'})\""))
      hl.bind("SUPER + Right", hl.dsp.exec_cmd("hyprctl dispatch \"hl.dsp.focus({workspace='r+1'})\""))
      hl.bind("SUPER + Up",    hl.dsp.exec_cmd("hyprctl dispatch \"hl.dsp.focus({workspace='r-1'})\""))
      hl.bind("SUPER + Down",  hl.dsp.exec_cmd("hyprctl dispatch \"hl.dsp.focus({workspace='r+1'})\""))

      -- workspace by number
      hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
      hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
      hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
      hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
      hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
      hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
      hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
      hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
      hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
      hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))

      -- move window to workspace
      hl.bind("SUPER + SHIFT + Left",  hl.dsp.exec_cmd("hyprctl dispatch \"hl.dsp.window.move({workspace='r-1'})\""))
      hl.bind("SUPER + SHIFT + Right", hl.dsp.exec_cmd("hyprctl dispatch \"hl.dsp.window.move({workspace='r+1'})\""))
      hl.bind("SUPER + SHIFT + 1",     hl.dsp.window.move({ workspace = 1 }))
      hl.bind("SUPER + SHIFT + 2",     hl.dsp.window.move({ workspace = 2 }))
      hl.bind("SUPER + SHIFT + 3",     hl.dsp.window.move({ workspace = 3 }))
      hl.bind("SUPER + SHIFT + 4",     hl.dsp.window.move({ workspace = 4 }))
      hl.bind("SUPER + SHIFT + 5",     hl.dsp.window.move({ workspace = 5 }))
      hl.bind("SUPER + SHIFT + 6",     hl.dsp.window.move({ workspace = 6 }))
      hl.bind("SUPER + SHIFT + 7",     hl.dsp.window.move({ workspace = 7 }))
      hl.bind("SUPER + SHIFT + 8",     hl.dsp.window.move({ workspace = 8 }))
      hl.bind("SUPER + SHIFT + 9",     hl.dsp.window.move({ workspace = 9 }))
      hl.bind("SUPER + SHIFT + 0",     hl.dsp.window.move({ workspace = 10 }))

      -- audio
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"))
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"))
      hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

      -- brightness
      hl.bind("SUPER + F5", hl.dsp.exec_cmd("ddcutil setvcp 10 - 5"))
      hl.bind("SUPER + F6", hl.dsp.exec_cmd("ddcutil setvcp 10 + 5"))

      -- mouse
      hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
      hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

      -- resize floating
      hl.bind("SUPER + CTRL + Left",  hl.dsp.window.resize({ x = -50, y = 0,   relative = true }), { repeating = true })
      hl.bind("SUPER + CTRL + Right", hl.dsp.window.resize({ x = 50,  y = 0,   relative = true }), { repeating = true })
      hl.bind("SUPER + CTRL + Up",    hl.dsp.window.resize({ x = 0,   y = -50, relative = true }), { repeating = true })
      hl.bind("SUPER + CTRL + Down",  hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }), { repeating = true })
    '';
  };

  home.sessionVariables = {
    XCURSOR_THEME = "macOS";
    XCURSOR_SIZE = "24";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };
}