{
  config,
  pkgs,
  lib,
  ...
}: let
  alt = "Mod1";
  cmd = "Mod4";
  #
  # ws0 = "0: dev";
  # ws1 = "1: misc";
  # ws2 = "2: web";
  # ws3 = "3: term";
  # ws4 = "4: music";
  # ws5 = "5: social";
  ws0 = "0";
  ws1 = "1";
  ws2 = "2";
  ws3 = "3";
  ws4 = "4";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
  ws9 = "9";
in {
  home.packages = with pkgs; [
    i3wsr
    autotiling
    # Requirements for bar
    ethtool
    iw
  ];

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      startup = [
        {
          command = "${lib.meta.getExe pkgs.i3wsr} --icons awesome";
          always = true;
        }
        {
          command = "${lib.meta.getExe pkgs.autotiling}";
          always = true;
        }
      ];

      bars = [
        {
          position = "top";
          fonts.size = 11.0;
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
        }
      ];

      assigns = {
        "workspace number ${ws0}" = [{class = "Code";}];
        "${ws1}" = [];
        "workspace number ${ws2}" = [{class = "Google-chrome";}];
        "${ws3}" = [];
        "${ws4}" = [];
        "workspace number ${ws5}" = [{class = ".spotify-wrapped";}];
      };
      keybindings = {
        "${cmd}+Shift+r" = "restart";
        "${cmd}+Shift+e" = "exec xfce4-session-logout";

        "${cmd}+Return" = "exec kitty";
        "${cmd}+space" = "exec \"rofi -show combi -combi-modes 'window,drun' -modes combi -show-icons\"";

        "${cmd}+w" = "kill";

        "${cmd}+0" = "workspace number ${ws0}";
        "${cmd}+1" = "workspace number ${ws1}";
        "${cmd}+2" = "workspace number ${ws2}";
        "${cmd}+3" = "workspace number ${ws2}";
        "${cmd}+4" = "workspace number ${ws4}";
        "${cmd}+5" = "workspace number ${ws5}";
        "${cmd}+6" = "workspace number ${ws6}";
        "${cmd}+7" = "workspace number ${ws7}";
        "${cmd}+8" = "workspace number ${ws8}";
        "${cmd}+9" = "workspace number ${ws9}";

        "${cmd}+Control+0" = "move container to workspace number ${ws0}";
        "${cmd}+Control+1" = "move container to workspace number ${ws1}";
        "${cmd}+Control+2" = "move container to workspace number ${ws2}";
        "${cmd}+Control+3" = "move container to workspace number ${ws2}";
        "${cmd}+Control+4" = "move container to workspace number ${ws4}";
        "${cmd}+Control+5" = "move container to workspace number ${ws5}";
        "${cmd}+Control+6" = "move container to workspace number ${ws6}";
        "${cmd}+Control+7" = "move container to workspace number ${ws7}";
        "${cmd}+Control+8" = "move container to workspace number ${ws8}";
        "${cmd}+Control+9" = "move container to workspace number ${ws9}";

        "${alt}+h" = "focus left";
        "${alt}+j" = "focus down";
        "${alt}+k" = "focus up";
        "${alt}+l" = "focus right";

        "${alt}+Shift+h" = "resize shrink width 15px";
        "${alt}+Shift+j" = "resize grow height 15px";
        "${alt}+Shift+k" = "resize shrink height 15px";
        "${alt}+Shift+l" = "resize grow width 15px";

        "${alt}+Control+h" = "move left";
        "${alt}+Control+j" = "move down";
        "${alt}+Control+k" = "move up";
        "${alt}+Control+l" = "move right";

        "${alt}+f" = "fullscreen toggle";
      };
      focus = {
        followMouse = false;
        newWindow = "focus";
      };

      gaps = {
        smartBorders = "on";
        smartGaps = true;
        inner = 12;
        outer = 5;
      };

      workspaceAutoBackAndForth = true;
    };
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        theme = "gruvbox-light";
        icons = "awesome";
        blocks = [
          {
            block = "time";
            interval = 60;
            format = "%a %d/%m %k:%M %p";
          }
          {
            block = "disk_space";
            format = "{icon}{used}/{total}";
          }
          {
            block = "cpu";
            format = "{utilization} {barchart}";
          }
          {
            block = "music";
            player = "spotify";
            buttons = ["prev" "play" "next"];
            hide_when_empty = true;
          }
          {
            block = "net";
          }
        ];
      };
    };
  };
}
