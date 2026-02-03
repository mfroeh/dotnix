{ pkgs, ... }:
{

  programs.neovide = {
    enable = true;
    settings = {
      maximized = true;
      font = {
        normal = [ "Iosevka Nerd Font Mono" ];
        size = 12;
      };
    };
  };

  home.packages = [ pkgs.nerd-fonts.iosevka ];

  globals = {
    # disable all neovide animations
    neovide_position_animation_length = 0;
    neovide_cursor_animation_length = 0.00;
    neovide_cursor_trail_size = 0;
    neovide_cursor_animate_in_insert_mode = false;
    neovide_cursor_animate_command_line = false;
    neovide_scroll_animation_far_lines = 0;
    neovide_scroll_animation_length = 0.00;
  };
  keymaps = [
    # resize font in neovide
    {
      key = "<C-+>";
      mode = "n";
      action = ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>";
    }
    {
      key = "<C-=>";
      mode = "n";
      action = ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>";
    }
    {
      key = "<C-->";
      mode = [
        "n"
        "v"
      ];
      action = ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>";
    }
    {
      key = "<C-0>";
      mode = [
        "n"
        "v"
      ];
      action = ":lua vim.g.neovide_scale_factor = 1<CR>";
    }
  ];
}
