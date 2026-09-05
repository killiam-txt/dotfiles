{pkgs, ...}: {
  home.file.".config/fish/aliases".source = ./aliases;

  programs.fish = {
    enable = true;
    package = pkgs.fishMinimal;

    shellInit = builtins.readFile ./config.fish;
    shellAliases = {
      nv = "nvim";
      cls = "clear";
      ls = "eza --icons";
    };

    functions = {
      __fish_command_not_found_handler = {
        body = "__fish_default_command_not_found_handler $argv[1]";
        onEvent = "fish_command_not_found";
      };
      fish_greeting = {
        body = "";
      };
      fish_prompt = {
        body = ''
          set -l status_copy $status
          set -l cwd (prompt_pwd)
          if test $status_copy -eq 0
            printf '%s%s%s · ' (set_color green) $cwd (set_color normal)
          else
            printf '%s%s%s · ' (set_color red) $cwd (set_color normal)
          end
        '';
      };
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";

      venv-autoload = {
        description = "Create .envrc to auto-activate the venv with direnv";
        body = ''
          echo "source .venv/bin/activate" > .envrc
          direnv allow
        '';
      };
    };
  };
}