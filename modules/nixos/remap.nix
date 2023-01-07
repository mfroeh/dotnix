{
  config,
  pkgs,
  lib,
  username,
  ...
}:
with lib; let
  cfg = config.services.remap;
in {
  options.services.remap = {
    enable = mkEnableOption "remap service";
    capsToCtrl = mkOption {
      type = types.bool;
      default = false;
    };
    swpBackslashBackspace = mkOption {
      type = types.bool;
      default = false;
    };
    ctrlLeftbraceToEsc = mkOption {
      type = types.bool;
      default = true;
    };
    macosTabControl = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    services.xremap = {
      serviceMode = "user";
      userName = username;
      # withSway = true;
      withGnome = true;
      watch = true;
      config = {
        modmap =
          []
          ++ optionals cfg.capsToCtrl [
            {
              name = "CapsLock -> Ctrl_L";
              remap = {
                CapsLock = "Ctrl_L";
              };
            }
          ]
          ++ optionals cfg.swpBackslashBackspace [
            {
              name = "Backslash <-> Backspace";
              remap = {
                Backslash = "Backspace";
                Backspace = "Backslash";
              };
            }
          ];
        keymap =
          []
          ++ optionals cfg.ctrlLeftbraceToEsc [
            {
              name = "C-[ -> Esc";
              remap = {
                "C-Leftbrace" = "Esc";
              };
            }
          ] ++ optionals cfg.macosTabControl [
            {
              name = "Cmd-Shift+] and Cmd-Shift+[ -> Ctrl-Tab and C-Shift-Tab";
              remap = {
                "Win_L-Shift_L-Rightbrace" = "Ctrl_L-Tab";
                "Win_L-Shift_L-Leftbrace" = "Ctrl_L-Shift-Tab";
              };
            }
            {
              name = "macOS tab creation and deletion except chrome, chromium";
              application = {
                not = [ "Google-chrome" "Chromium-browser" ];
              };
              remap = {
                "Win_L-t" = "Ctrl_L-Shift-t";
                "Win-w" = "Ctrl_L-Shift-w";
              };
            }
            {
              name = "macOS tab creation and deletion only in chrome, chromium";
              application = {
                only = [ "Google-chrome" "Chromium-browser" ];
              };
              remap = {
                "Win_L-t" = "Ctrl_L-t";
                "Win-w" = "Ctrl_L-w";
              };
            }
          ];
      };
    };
  };
}
