{
  config,
  pkgs,
  lib,
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
  };

  config = mkIf cfg.enable {
    services.xremap = {
      serviceMode = "system";
      # withSway = true;
      # withGnome = true;
      withX11 = true;
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
          ];
      };
    };
  };
}
