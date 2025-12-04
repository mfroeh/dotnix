{ pkgs, lib, ... }:
let
  css = ''
        * {
        font-size: 13px;
        }
        window#waybar {
    		background: rgba(43, 48, 59, 0.9);
    		border-bottom: 3px solid rgba(100, 114, 125, 0.5);
    		color: white;
        }
  '';
in
{
  programs.waybar = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    # systemd.enable = true;
    # systemd.target = "sway-session.target";
    style = css;
    settings = [
      {
        name = "bottom";
        layer = "top";
        position = "bottom";
        height = 25;
        modules-center = [
          "sway/window"
        ];
        modules-left = [ "sway/workspaces" ];
        "sway/workspaces" = {
          "format" = "{name}";
          "on-click" = "activate";
          "sort-by-number" = true;
        };
        modules-right = [
          "wlr/taskbar"
          "tray"
          "pulseaudio"
          "clock"
          "custom/power"
        ];
        "wlr/taskbar" = {
          format = "{icon}";
          on-click = "activate";
          on-click-middle = "close";
        };
        "sway/window" = {
          format = "{title}";
        };
        "custom/power" = {
          format = " ⏻ ";
          tooltip = false;
          on-click = "wlogout";
        };
        clock = {
          interval = 1;
          format = "{:%a %d.%m %H:%M}";
        };
        pulseaudio = {
          format = "{volume}% ";
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          on-click-right = "${pkgs.pamixer}/bin/pamixer -t";
          on-scroll-up = "${pkgs.pamixer}/bin/pamixer -i 5";
          on-scroll-down = "${pkgs.pamixer}/bin/pamixer -d 5";
        };
      }
    ];
  };

  programs.wlogout = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    layout = [
      {
        label = "lock";
        text = "Lock (l)";
        action = "swaylock";
        keybind = "l";
      }
      {
        label = "hibernate";
        text = "Suspend to disk (h)";
        action = "systemctl hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        text = "Logout (e)";
        action = "swaymsg exit";
        keybind = "e";
      }
      {
        label = "shutdown";
        text = "Shutdown (s)";
        action = "systemctl poweroff";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend to RAM (u)";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot (r)";
        keybind = "r";
      }
    ];
  };

}
