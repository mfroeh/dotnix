{ config, pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;
    theme = "Rosé Pine";
    settings = {
      font_size = 14;
      enable_audio_bell = false;
      cursor_blink_interval = 0;
      confirm_os_window_close = 0;
    };
  };
}
