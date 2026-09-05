{ lib, ... }:
{
  imports = [
    ./packages.nix

    # wm
    ./modules/wm/hyprland/default.nix
    ./modules/wm/niri/default.nix

    # editors
    ./modules/ide/nvim/default.nix

    # terminal stuff
    ./modules/terminal/kitty/default.nix

    # shell stuff
    ./modules/shell/bash/default.nix
    ./modules/shell/fish/default.nix

    # user stuff
    ./modules/user/direnv/default.nix
    # ./modules/user/bemenu/default.nix
    ./modules/user/dunst/default.nix
    ./modules/user/git/default.nix
    # ./modules/user/stylix/default.nix
    ./modules/user/spotify/default.nix
    ./modules/user/waybar/default.nix
    ./modules/user/fastfetch/default.nix
    ./modules/user/matugen/default.nix
  ];

  home.file.".config/starship.toml".source = ./starship.toml;

  home.file.".config/fastfetch/stuff.txt".source = ./modules/user/fastfetch/stuff.txt;

  home.activation.btopConf = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.config/btop
    if [ ! -f $HOME/.config/btop/btop.conf ]; then
      echo 'color_theme = "pywal"' > $HOME/.config/btop/btop.conf
    fi
  '';

  home.file.".config/xdg-desktop-portal/hyprland-portals.conf".text = ''
    [preferred]
    default=hyprland;gtk
    org.freedesktop.impl.portal.Screenshot=hyprland
    org.freedesktop.impl.portal.ScreenCast=hyprland
  '';

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/jpg" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "video/mp4" = "mpv.desktop";
      "video/mkv" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/avi" = "mpv.desktop";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
    };
  };

  home.file.".config/swaylock/config".text = ''
    color=000000
    font=Maple Mono NF
    font-size=14
    indicator-radius=0
    indicator-thickness=0
    show-failed-attempts
    hide-keyboard-layout
  '';

  home.username = "killiam";
  home.homeDirectory = "/home/killiam";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}