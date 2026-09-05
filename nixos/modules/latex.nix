{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    texliveSmall
  ];
}