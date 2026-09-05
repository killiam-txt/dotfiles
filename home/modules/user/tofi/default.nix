{lib, ...}: {
  programs.tofi = {
    enable = true;
    settings = {
      border-width = 0;
      height = "100%";
      num-results = 5;
      outline-width = 0;
      padding-left = "35%";
      font-size = lib.mkForce 24;
      padding-top = "35%";
      result-spacing = 25;
      width = "100%";
    };
  };
}
