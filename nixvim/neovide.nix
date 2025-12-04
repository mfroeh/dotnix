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

  programs.nixvim = {
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
  };
}
