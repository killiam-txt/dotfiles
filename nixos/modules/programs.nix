{pkgs, ...}: {
  environment.sessionVariables = {
    #WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    #XDG_CURRENT_DESKTOP = "Hyprland";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    #AQ_NO_MODIFIERS = "1";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    XDG_SESSION_TYPE = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;
  security.pam.services.swaylock = {};

  environment.systemPackages = with pkgs; [
    # essential
    curl
    pavucontrol

    # useful
    wl-clipboard
    xdg-desktop-portal
    gnumake
    git-credential-manager
    pipewire
    pulseaudio
    xdg-desktop-portal-wlr
    (ffmpeg.override { withNvenc = true; })

    # notifications
    libnotify

    # screenshot utils
    grim
    slurp
    hyprpicker

    # email client
    thunderbird

    # wayland
    apple-cursor
    swaybg
    egl-wayland
    
    # thunar stuff
    ffmpegthumbnailer
  ];

  environment.gnome.excludePackages = [pkgs.gnome-tour];
  services.xserver.excludePackages = [pkgs.xterm];
  services.xserver.desktopManager.xterm.enable = false;

  programs.steam.enable = true;
  services.udisks2.enable = true;

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
    ];
  };

  programs.xfconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  services.gvfs.enable = true;
  services.tumbler.enable = true;
}