{ ... }:
{
  programs.nixvim = {
    plugins.flash = {
      enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
      }
    ];
  };
}
