{...}: {
  virtualisation.docker.enable = true;
  users.users.killiam.extraGroups = ["docker"];
}