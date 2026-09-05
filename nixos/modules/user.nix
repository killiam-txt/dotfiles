{ pkgs, ... }:
{
  users.users.killiam = {
    isNormalUser = true;
    description = "killiam";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "i2c"
    ];
    shell = pkgs.fishMinimal;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
