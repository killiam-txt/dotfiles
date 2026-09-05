{...}: {
  home.file.".config/matugen/config.toml".source = ./config.toml;
  home.file.".config/matugen/templates/colors.json".source = ./templates/colors.json;
  home.file.".config/matugen/templates/hyprland/apply-colors.sh".source = ./templates/hyprland/apply-colors.sh;
  home.file.".config/matugen/templates/waybar/colors.css".source = ./templates/waybar/colors.css;
  home.file.".config/matugen/templates/btop/btop.theme".source = ./templates/btop/btop.theme;
  home.file.".config/matugen/templates/btop/gen-pywal-btop.sh" = {
    source = ./templates/btop/gen-pywal-btop.sh;
    executable = true;
  };
  home.file.".config/matugen/templates/cava/gen-pywal-cava.sh" = {
    source = ./templates/cava/gen-pywal-cava.sh;
    executable = true;
  };
  home.file.".config/matugen/templates/kitty/colors.conf".source = ./templates/kitty/colors.conf;
  home.file.".config/matugen/templates/gtk-3.0/gtk.css".source = ./templates/gtk-3.0/gtk.css;
  home.file.".config/matugen/templates/gtk-4.0/gtk.css".source = ./templates/gtk-4.0/gtk.css;
  home.file.".config/matugen/templates/wlogout/style.css".source = ./templates/wlogout/style.css;
  home.file.".config/wlogout/layout".source = ./templates/wlogout/layout;
  home.file.".config/matugen/templates/fuzzel/fuzzel.ini".source = ./templates/fuzzel/fuzzel.ini;

  # wlogout -> log out
  home.file.".local/bin/wlogout-logout" = {
    text = ''
      #!/usr/bin/env bash
      if pgrep niri > /dev/null; then
        niri msg action quit --skip-confirmation
      else
        hyprctl eval "hl.dispatch(hl.dsp.exit())"
      fi
    '';
    executable = true;
  };
}