{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    themeFile = "Bright_Lights";
    settings = {
      font_size = 10;
      enable_audio_bell = false;
      cursor_blink_interval = 0;
      confirm_os_window_close = 0;
      # hide_window_decorations = true; # removes border (only works with some window managers)
    };
    font.name = "FiraCode Nerd Font Mono";
  };

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}
