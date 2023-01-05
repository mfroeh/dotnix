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
  ws0 = "0] dev";
  ws1 = "1] misc";
  ws2 = "2] web";
  ws3 = "3] misc";
  ws4 = "4] music";
  ws5 = "5] social";
  ws6 = "6]";
  ws7 = "7]";
  ws8 = "8]";
  ws9 = "9]";
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
        # {
        #   command = "${lib.meta.getExe pkgs.i3wsr} --icons awesome";
        #   always = true;
        # }
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
        "workspace ${ws0}" = [{class = "Code";}];
        "${ws1}" = [];
        "workspace ${ws2}" = [{class = "Google-chrome";}];
        "${ws3}" = [];
        "${ws4}" = [];
        "workspace ${ws5}" = [{class = ".spotify-wrapped";}];
      };
      keybindings = {
        "${cmd}+Shift+r" = "restart";
        "${cmd}+Shift+e" = "exec xfce4-session-logout";

        "${cmd}+Return" = "exec kitty";
        "${cmd}+space" = "exec \"rofi -show combi -combi-modes 'window,drun' -modes combi -show-icons\"";

        "${cmd}+w" = "kill";

        "${cmd}+0" = "workspace ${ws0}";
        "${cmd}+1" = "workspace ${ws1}";
        "${cmd}+2" = "workspace ${ws2}";
        "${cmd}+3" = "workspace ${ws2}";
        "${cmd}+4" = "workspace ${ws4}";
        "${cmd}+5" = "workspace ${ws5}";
        "${cmd}+6" = "workspace ${ws6}";
        "${cmd}+7" = "workspace ${ws7}";
        "${cmd}+8" = "workspace ${ws8}";
        "${cmd}+9" = "workspace ${ws9}";

        "${cmd}+Control+0" = "move container to workspace ${ws0}";
        "${cmd}+Control+1" = "move container to workspace ${ws1}";
        "${cmd}+Control+2" = "move container to workspace ${ws2}";
        "${cmd}+Control+3" = "move container to workspace ${ws2}";
        "${cmd}+Control+4" = "move container to workspace ${ws4}";
        "${cmd}+Control+5" = "move container to workspace ${ws5}";
        "${cmd}+Control+6" = "move container to workspace ${ws6}";
        "${cmd}+Control+7" = "move container to workspace ${ws7}";
        "${cmd}+Control+8" = "move container to workspace ${ws8}";
        "${cmd}+Control+9" = "move container to workspace ${ws9}";

        "${cmd}+Shift+0" = "move container to workspace ${ws0}, workspace ${ws0}";
        "${cmd}+Shift+1" = "move container to workspace ${ws1}, workspace ${ws1}";
        "${cmd}+Shift+2" = "move container to workspace ${ws2}, workspace ${ws2}";
        "${cmd}+Shift+3" = "move container to workspace ${ws2}, workspace ${ws3}";
        "${cmd}+Shift+4" = "move container to workspace ${ws4}, workspace ${ws4}";
        "${cmd}+Shift+5" = "move container to workspace ${ws5}, workspace ${ws5}";
        "${cmd}+Shift+6" = "move container to workspace ${ws6}, workspace ${ws6}";
        "${cmd}+Shift+7" = "move container to workspace ${ws7}, workspace ${ws7}";
        "${cmd}+Shift+8" = "move container to workspace ${ws8}, workspace ${ws8}";
        "${cmd}+Shift+9" = "move container to workspace ${ws9}, workspace ${ws9}";

        "${cmd}+h" = "focus left";
        "${cmd}+j" = "focus down";
        "${cmd}+k" = "focus up";
        "${cmd}+l" = "focus right";

        "${cmd}+Shift+h" = "resize shrink width 15px";
        "${cmd}+Shift+j" = "resize grow height 15px";
        "${cmd}+Shift+k" = "resize shrink height 15px";
        "${cmd}+Shift+l" = "resize grow width 15px";

        "${cmd}+Control+h" = "move left";
        "${cmd}+Control+j" = "move down";
        "${cmd}+Control+k" = "move up";
        "${cmd}+Control+l" = "move right";

        "${cmd}+f" = "fullscreen toggle";
        # "${cmd}+Control+h" = "move container to workspace number 11";
        # "${cmd}+Shift+h" = "move container to workspace number 11, workspace number 11";
        # "${cmd}+h" = "workspace number 11";
        "${cmd}+Shift+space" = "floating toggle";
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
