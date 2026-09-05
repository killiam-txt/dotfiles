{pkgs, ...}: {
  # ollama llama daemon with cuda aceleration
  services.ollama = {
    enable = true;
    host = "0.0.0.0";
    package = pkgs.ollama-cuda;
  };

  # ollama cli client
  environment.systemPackages = with pkgs; [
    ollama-cuda
  ];
}