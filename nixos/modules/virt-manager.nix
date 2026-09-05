{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    virt-manager
  ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.killiam.extraGroups = [ "libvirtd" ];

  environment.etc."qemu/bridge.conf".text = "allow br0\n";
  
  security.wrappers.qemu-bridge-helper = {
    source = "${pkgs.qemu}/libexec/qemu-bridge-helper";
    owner = "root";
    group = "root";
    setuid = true;
  };
}