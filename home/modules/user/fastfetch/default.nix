{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "nixos";   # "/home/killiam/.config/fastfetch/stuff.txt";
        type = "builtin";   # "file";
        height = 18;
        padding.top = 1;
      };
      display = {
        separator = " ➜ ";
        color = "cyan";
      };
      modules = [
        "break"
        "break"
        "break"
        {
          type = "title";
          key = " ├  ";
          keyColor = "blue";
          format = "{1}@{2}";
          color = "white";
        }
        { type = "os"; key = " ├  "; keyColor = "31"; }
        { type = "kernel"; key = " ├  "; keyColor = "31"; }
        { type = "packages"; key = " ├ 󰏖 "; keyColor = "31"; }
        { type = "shell"; key = " ├ $ "; keyColor = "31"; }
        { type = "wm"; key = " ├  "; keyColor = "32"; }
        { type = "disk"; key = " ├ 󰃭 "; keyColor = "33"; format = "{days} days"; folders = "/"; }
        #{ type = "wmtheme"; key = " ├ 󰉼 "; keyColor = "32"; }
        #{ type = "icons"; key = " ├ 󰀻 "; keyColor = "32"; }
        { type = "cursor"; key = " ├  "; keyColor = "32"; }
        { type = "terminal"; key = " ├  "; keyColor = "32"; }
        { type = "terminalfont"; key = " ├ 󰬶 "; keyColor = "32"; }
        { type = "monitor"; key = " ├ 󰍹 "; keyColor = "33"; }
        { type = "cpu"; format = "{1} ({3}) @ {7} GHz"; key = " ├  "; keyColor = "33"; }
        { type = "gpu"; format = "{1} {2} @ {12} GHz"; key = " ├ 󰢮 "; keyColor = "33"; }
        { type = "memory"; key = " ├  "; keyColor = "33"; }
        { type = "swap"; key = " ├ 󰓡 "; keyColor = "33"; }
        { type = "disk"; key = " ├ 󰋊 "; keyColor = "33"; }
        {
          type = "colors";
          symbol = "square";
          paddingLeft = 2;
          colors = ["black" "red" "green" "yellow" "blue" "magenta" "cyan" "white"];
        }
        "break"
        "break"
      ];
    };
  };
}