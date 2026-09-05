{
  pkgs,
  inputs,
  lib,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
    ];

    theme = lib.mkForce spicePkgs.themes.text;
    colorScheme = "custom";
    customColorScheme = {
      text = "FFFFFF";
      subtext = "C0C0C0";
      sidebar-text = "FFFFFF";
      main = "000000";
      sidebar = "1A1A1A";
      player = "000000";
      card = "121212";
      shadow = "000000";
      selected-row = "404040";
      button = "B0B0B0";
      button-active = "FFFFFF";
      button-disabled = "4A4A4A";
      tab-active = "FFFFFF";
      notification = "121212";
      notification-error = "FFFFFF";
      misc = "000000";
    };
  };
}
