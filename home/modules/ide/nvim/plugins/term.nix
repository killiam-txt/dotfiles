{
  plugins.toggleterm = {
    enable = true;
    settings = {
      direction = "float";
      float_opts = {
        border = "single";
        height = 30;
        width = 130;
      };
      shell = "fish";
      open_mapping = "[[<c-t>]]";
    };
  };
}
