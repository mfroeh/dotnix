{ ... }:
{
  programs.nixvim = {
    plugins.flash = {
      enable = true;
      settings = {
        label = {
          rainbow = {
            enabled = true;
          };
        };
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
