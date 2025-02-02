{ ... }:
let
  css = ''
    * {
    font-size: 13px;
    }
    window#waybar {
    background: rgba(43, 48, 59, 0.8);
    border-bottom: 3px solid rgba(100, 114, 125, 0.5);
    color: white;
    }

    button:hover {
    background: rgba(0, 0, 0, 0.2);
    box-shadow: inherit;
    }

    #pulseaudio-slider trough, #backlight-slider trough {
    min-height: 10px;
    min-width: 80px;
    }

    #workspaces button {
    padding: 0 5px;
    background-color: transparent;
    color: #ffffff;
    border-radius: 0;
    }

    #workspaces button.active {
    background-color: #64727D;  /* or any color you prefer */
    border-bottom: 3px solid #ffffff;  /* adds an underline indicator */
    }
  '';
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";
    style = css;
    settings = [
      {
        name = "bottom";
        layer = "top";
        position = "top";
        height = 30;
        modules-center = [ "wlr/taskbar" ];
        modules-left = [ "hyprland/workspaces" ];
        "hyprland/workspaces" = {
          "format" = "{name}";
          "on-click" = "activate";
          "sort-by-number" = true;
        };
        modules-right = [
          "tray"
          "hyprland/language"
          "pulseaudio/slider"
          "pulseaudio"
          "clock"
          "custom/power"
        ];
        "wlr/taskbar" = {
          format = "{icon} {name}";
          icon-size = 13;
          on-click = "activate";
          on-click-middle = "close";
        };
        "custom/power" = {
          format = " ⏻ ";
          tooltip = false;
          on-click = "wlogout";
        };
        clock = {
          interval = 1;
          format = "{:%A, %F %H:%M}";
        };
        pulseaudio = {
          format = "{volume}% ";
          on-click = "pavucontrol";
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
        };
        "hyprland/language" = {
          format = " {} ";
          format-en = "🇺🇸";
          format-de = "🇩🇪";
        };
        # todo: won't work
        tray = {
          icon-size = 13;
          spacing = 5;
        };
      }
    ];
  };
}
