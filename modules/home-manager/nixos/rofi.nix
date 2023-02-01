{ config, pkgs, lib, ... }:
let themeDir = "${pkgs.rofi}/share/rofi/themes/";
in {
  home.packages = with pkgs; [ fzf ];
  programs.rofi = {
    enable = true;
    theme = "${themeDir}/gruvbox-light-soft.rasi";
    terminal = "${lib.meta.getExe pkgs.kitty}";
    plugins = with pkgs; [
      rofi-emoji
      rofi-calc
      rofi-power-menu
      haskellPackages.greenclip
    ];
    extraConfig = {
      modi =
        "window,drun,filebrowser,calc,emoji,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu,clipboard:${pkgs.haskellPackages.greenclip}/bin/greenclip print,combi";
      combi-modi = "window,drun,power-menu,";
      sort = true;
      sorting-method = "fzf";
      disable-history = false;
      show-icons = true;
      matching = "fuzzy";

      # Unset some bindings
      kb-remove-to-eol = "";
      kb-accept-entry = "Return";
      kb-remove-char-back = "BackSpace";
      kb-mode-complete = "";

      kb-row-up = "Up,Control+k,Shift+Tab";
      kb-row-down = "Down,Control+j";
      kb-mode-next = "Shift+Right,Control+Tab,Control+l";
      kb-mode-previous = "Shift+Left,Control+Shift+Tab,Control+h";
    };
  };

  systemd.user.services.greenclip = {
    Unit = {
      Description = "Greenclip clipboard manager";
      After = [ "network-online.target" ];
    };
    Install.WantedBy = [ "default.target" ];
    Service = {
      Type = "notify";
      ExecStart = "${pkgs.haskellPackages.greenclip}/bin/greenclip daemon";
      Restart = "always";
      RestartSec = "10s";
    };
  };
}
