{ ... }:
{
  programs.nixvim = {
    plugins.zen-mode.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>zz";
        action.__raw = ''
          function() 
            require('zen-mode').toggle({ window = { width = 0.7 }}) 
          end
        '';
      }
    ];
  };

}
