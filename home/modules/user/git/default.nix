{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "user";
        email = "your-email@example.com";
      };

      credential.helper = "store";
      push.default = "current";
      init.defaultBranch = "main";
      pull.rebase = true;
      fetch.prune = true;

      # @user
      # url."git@github.com-user:".insteadOf = "https://github.com/user/";
      # url."git@github.com-user:".pushInsteadOf = "https://github.com/user/";
    };
  };
}

# note: use yours