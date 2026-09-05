{inputs, ...}: {
  imports = [
    inputs.spicetify-nix.nixosModules.default

    ./hardware-configuration.nix
    ./modules/networking.nix
    ./modules/localization.nix
    ./modules/xserver.nix
    ./modules/audio.nix
    ./modules/user.nix
    ./modules/programs.nix
    ./modules/boot.nix
    ./modules/fonts.nix
    ./modules/docker.nix
    ./modules/gnome-boxes.nix
    ./modules/latex.nix
    ./modules/virt-manager.nix
    # ./modules/ollama.nix
    ./modules/waydroid.nix
    ./modules/tablet.nix
    ./modules/brightness.nix

    # gaming shi
    ./modules/gaming.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
