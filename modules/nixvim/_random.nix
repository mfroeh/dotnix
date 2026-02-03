{

  plugins.grug-far = {
    enable = true;
    settings = {
      debounceMs = 200;
      engine = "ripgrep";
      settings = {
        engines = {
          ripgrep = {
            path = "rg";
          };
        };
      };
    };
  };

  # todo: will need targets or something since we cannot jump between quotes by default lol

  # todo replace with nvim variant
  plugins.visual-multi = {
    enable = true;
    settings = {
      default_mappings = 0;
      maps = {
        "Find Subword Under" = "gn";
        "Skip Region" = "gN";
        "Undo" = "u";
        "Redo" = "<C-r>";
      };
    };
  };
}
