{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # docker
  networking.firewall.trustedInterfaces = [ "docker0" ];

  # ollama + localsend
  networking.firewall.allowedTCPPorts = [ 11434 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # bridge connection and stuff
  # networking.networkmanager.unmanaged = [ "eno1" "br0" ];
  # networking.bridges.br0.interfaces = [ "eno1" ];
  # networking.interfaces.br0.useDHCP = true;
  # networking.interfaces.eno1.useDHCP = false;
}
