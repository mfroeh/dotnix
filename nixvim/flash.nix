{ ... }:
{
  programs.nixvim = {
    plugins.flash = {
      enable = true;
      settings = {
        modes = {
          char = {
            enabled = false;
          };
        };
      };
    };

    keymaps = [
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "S";
        action = "<cmd>lua require('flash').treesitter()<cr>";
      }
      {
        mode = "o";
        key = "r";
        action = "<cmd>lua require('flash').remote()<cr>";
      }
    ];
  };
}
