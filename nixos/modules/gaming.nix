{ pkgs, ... }:
{
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    extraPackages = with pkgs; [
      xdg-utils
    ];
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
    protonplus
    heroic
    mangohud
  ];
}