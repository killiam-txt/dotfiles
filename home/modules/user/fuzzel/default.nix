{...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Maple Mono NF:size=12";
        width = 40;
        lines = 8;
        terminal = "kitty";
      };
      colors = {
        background = "1a1a1aff";
        text = "c0c0c0ff";
        match = "ffffffff";
        selection = "2e2e2eff";
        selection-text = "ffffffff";
        border = "2e2e2eff";
      };
      border = {
        width = 2;
        radius = 0;
      };
    };
  };
}