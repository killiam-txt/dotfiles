{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.noto
      nerd-fonts.jetbrains-mono
      maple-mono.NF
      noto-fonts-cjk-sans  #japanese
      noto-fonts-cjk-serif #japanese docs
    ];

    fontconfig.defaultFonts = {
      serif = [ "Maple Mono NF" ];
      sansSerif = [ "Maple Mono NF" ];
      monospace = [ "Maple Mono NF" ];
    };
  };
}
