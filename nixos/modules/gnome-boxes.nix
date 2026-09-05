{ ... }: {
  virtualisation.libvirtd.enable = true;
  users.users.killiam.extraGroups = [ "libvirtd" ];
}