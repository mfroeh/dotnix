{ ... }:
{
  programs.nixvim = {
    plugins.neotest = {
      enable = true;
      adapters = {
        # another one
        # go = {
        #   enable = true;
        # };
        golang = {
          enable = true;
        };
      };
    };

    keymaps = [
      {
        key = "<leader>tr";
        mode = "n";
        action = ":lua require('neotest').run.run()<cr>";
      }
    ];
  };
}
