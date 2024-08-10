{ ... }: {
  programs.kitty = {
    enable = true;
    theme = "Spacedust";
    settings = {
      font_size = 14;
      enable_audio_bell = false;
      cursor_blink_interval = 0;
      confirm_os_window_close = 0;
      # hide_window_decorations = true; # removes border (only works with some window managers)
    };
    font.name = "Hack Nerd Font";
  };
}
