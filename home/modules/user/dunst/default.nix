{lib, ...}: {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        offset = "15x15";
        corner_radius = 0;
        transparency = 50;
        frame_width = 1;
        timeout = 3;
        font = lib.mkForce "Maple Mono NF 10";
        icon_corner_radius = 0;
        min_icon_size = 56;
      };

      urgency_normal = {
        background = "#1a1a1a";
        foreground = "#c0c0c0";
        frame_color = "#2e2e2e";
      };
    };
  };
}
