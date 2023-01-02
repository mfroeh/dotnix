{
  config,
  pkgs,
  lib,
  ...
}: let
  themeDir = "${pkgs.rofi}/share/rofi/themes/";
in {
  programs.rofi = {
    enable = true;
    theme = "${themeDir}/gruvbox-light-soft.rasi";
    terminal = "${lib.meta.getExe pkgs.kitty}";
    extraConfig = {
      # Unset some bindings
      kb-remove-to-eol= "";
      kb-accept-entry = "Return";
      kb-remove-char-back = "BackSpace";
      kb-mode-complete = "";

      kb-row-up = "Up,Control+k,Shift+Tab";
      kb-row-down = "Down,Control+j";
      kb-mode-next = "Shift+Right,Control+Tab,Control+l";
      kb-mode-previous = "Shift+Left,Control+Shift+Tab,Control+h";
    };
  };
}
