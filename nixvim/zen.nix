{ ... }:
{
  programs.nixvim = {
    plugins.zen-mode.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>zz";
        action = "<cmd>ZenMode<cr>";
      }
    ];
  };

}
