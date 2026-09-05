{
  plugins.mini-basics = {
    enable = true;
    settings = {
      autocommands = {
        basic = true;
        relnum_in_visual_mode = false;
      };
      mappings = {
        basic = true;
        move_with_alt = false;
        option_toggle_prefix = "\\";
        windows = false;
      };
      options = {
        basic = true;
        extra_ui = false;
        win_borders = "auto";
      };
      silent = false;
    };
  };
}
