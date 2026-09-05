{
  plugins.mini-git = {
    enable = true;
    settings = {
      command = {
        split = "horizontal";
      };
      job = {
        timeout = 20000;
      };
    };
  };
}
