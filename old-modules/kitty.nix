{ pkgs, config, ... }:
{
  programs.kitty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.kitty;
    themeFile = "gruvbox-dark-soft";
    settings = {
      font_size = 10;
      enable_audio_bell = false;
      cursor_blink_interval = 0;
      confirm_os_window_close = 0;
      # hide_window_decorations = true; # removes border (only works with some window managers)
    };
    font.name = "FiraCode Nerd Font Mono";
  };

  home.packages = [ pkgs.nerd-fonts.fira-code ];
}
