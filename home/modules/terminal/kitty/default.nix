{lib, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "Maple Mono NF";
      size = 12;
    };
    extraConfig = ''
      include ~/.config/kitty/colors.conf
      include ~/.cache/wal/colors-kitty.conf
      background_opacity 0.85
    '';
    settings = {
      confirm_os_window_close = 0;
      scrollback_lines = 10000;
      cursor_shape = "beam";
      cursor_beam_thickness = 1;
      window_padding_width = 4;
      background_opacity = lib.mkForce "0.85";
      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty-killiam";
    };
  };
}