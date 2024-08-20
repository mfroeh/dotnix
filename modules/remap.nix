{ config, pkgs, lib, username, inputs, ... }:
with lib;
with types;
let cfg = config.services.remap;
in
{
  imports = [ inputs.xremap-flake.nixosModules.default ];

  options.services.remap = {
    # wm = mkOption {
    #   type = types.enum [ "none" "sway" "gnome" "x11" "hyprland" ];
    # };
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
      default = false;
    };
    macosTabControl = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.xremap = {
      serviceMode = "system";
      # withX11 = (cfg.wm == "x11");
      # withSway = (cfg.wm == "sway");
      # withGnome = (cfg.wm == "gnome");
      # withHypr = (cfg.wm == "hyprland");
      watch = true;
      config = {
        modmap = [ ] ++ optionals cfg.capsToCtrl [{
          name = "CapsLock -> Ctrl_L";
          remap = { CapsLock = "Ctrl_L"; };
        }] ++ optionals cfg.swpBackslashBackspace [{
          name = "Backslash <-> Backspace";
          remap = {
            Backslash = "Backspace";
            Backspace = "Backslash";
          };
        }];
        keymap = [ ] ++ optionals cfg.ctrlLeftbraceToEsc [{
          name = "C-[ -> Esc";
          remap = { "C-Leftbrace" = "Esc"; };
        }] ++ optionals cfg.macosTabControl [
          {
            name = "Cmd-Shift+] and Cmd-Shift+[ -> Ctrl-Tab and C-Shift-Tab";
            remap = {
              "Win_L-Shift_L-Rightbrace" = "Ctrl_L-Tab";
              "Win_L-Shift_L-Leftbrace" = "Ctrl_L-Shift-Tab";
            };
          }
          {
            name = "macOS tab creation and deletion except chrome, chromium";
            application = { not = [ "Google-chrome" "Chromium-browser" ]; };
            remap = {
              "Win_L-t" = "Ctrl_L-Shift-t";
              "Win-w" = "Ctrl_L-Shift-w";
            };
          }
          {
            name = "macOS tab creation and deletion only in chrome, chromium";
            application = { only = [ "Google-chrome" "Chromium-browser" ]; };
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
