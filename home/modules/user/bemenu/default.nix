{...}: {
  programs.bemenu = {
    enable = true;
    settings = {
      border = 0;
      border-radius = 0;
      list = "8 down";
      width-factor = 0.3;
      line-height = 28;
      center = true;
      ignorecase = true;
      prompt = "󰍉";

      # theme
      nb = "#1a1a1a";  # normal background
      nf = "#c0c0c0";  # normal foreground
      ab = "#1a1a1a";  # alternate background
      af = "#888888";  # alternate foreground
      hb = "#2e2e2e";  # highlight background
      hf = "#ffffff";  # highlight foreground
      sb = "#2e2e2e";  # selected background
      sf = "#ffffff";  # selected foreground
      tb = "#111111";  # title background
      tf = "#888888";  # title foreground
    };
  };
}