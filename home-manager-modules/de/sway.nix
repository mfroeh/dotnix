{
  self,
  pkgs,
  lib,
  inputs,
  system,
  config,
  ...
}:
let
  mod = "Mod4";
  anyrun-toggle = pkgs.writeShellScriptBin "toggle" ''
    if pgrep anyrun > /dev/null; then
      pkill anyrun
    else
      exec ${pkgs.anyrun}/bin/anyrun
    fi
  '';
in
{
  config = lib.mkIf pkgs.stdenv.isLinux {
    home.file."${config.xdg.configHome}/wallpapers" = {
      source = "${self}/config/wallpapers";
      recursive = true;
    };

    wayland.windowManager.sway = {
      enable = true;
      config = {
        startup = [
          {
            command = "${pkgs.swtchr}/bin/swtchrd";
            always = true;
          }
          {
            # force restart to ensure update (still does not work sometimes :/)
            command = "systemctl --user restart shikane.service";
            always = true;
          }
          {
            command = "${pkgs.swww}/bin/swww img ${self}/config/wallpapers/aishot-3516.jpg";
            always = true;
          }
          { command = "ghostty"; }
          { command = "firefox"; }
        ];
        bars = [
          {
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
          }
        ];
        input = {
          "type:keyboard" = {
            repeat_delay = "250";
            repeat_rate = "50";
          };
        };
        terminal = "${pkgs.ghostty}/bin/ghostty";
        assigns = {
          "1" = [ { app_id = "ghostty"; } ];
          "2" = [ { app_id = "firefox"; } ];
        };
        workspaceOutputAssign = [
          {
            workspace = "1";
            output = "DP-2";
          }
          {
            workspace = "2";
            output = "DP-2";
          }
          {
            workspace = "3";
            output = "DP-2";
          }
          {
            workspace = "4";
            output = "HDMI-A-1";
          }
          {
            workspace = "5";
            output = "HDMI-A-1";
          }
        ];
        modifier = mod;
        keybindings = {
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+Return" = "workspace number 1";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";

          "${mod}+f" = "fullscreen toggle";
          "${mod}+v" = "floating toggle";

          "${mod}+o" = "exec ${anyrun-toggle}/bin/toggle";
          "${mod}+Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";

          "${mod}+e" = "exec ${pkgs.kdePackages.dolphin}/bin/dolphin";
          "${mod}+Shift+q" = "kill focused";

          "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 5";
          "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 5";
          "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";

          "${mod}+Mod1+l" = "exec wlogout";
          "${mod}+Mod1+e" =
            "exec swaynag -t warning -m 'What do you want to do?' -b 'Exit Sway' 'swaymsg exit'";
        };
        fonts = {
          names = [ "DejaVu Sans" ];
          size = 10.0;
        };
        window.commands = [
          {
            criteria = {
              shell = "xwayland";
            };
            command = "title_format \"%title [XWayland]\"";
          }
          {
            criteria = {
              app_id = "firefox";
            };
            command = "inhibit_idle fullscreen";
          }
          {
            criteria = {
              window_role = "pop-up";
            };
            command = "floating enable";
          }
          {
            criteria = {
              window_role = "bubble";
            };
            command = "floating enable";
          }
          {
            criteria = {
              window_role = "dialog";
            };
            command = "floating enable";
          }
          {
            criteria = {
              window_type = "dialog";
            };
            command = "floating enable";
          }
        ];
      };
      extraConfig = ''
        bindsym ${mod}+Tab mode swtchr; exec ${pkgs.swtchr}/bin/swtchr
        bindsym ${mod}+Shift+Tab mode swtchr; exec ${pkgs.swtchr}/bin/swtchr

        mode swtchr bindsym Backspace mode default
        		'';
      extraOptions = [
        "--debug"
        "--unsupported-gpu"
      ];
    };

    services.shikane = {
      enable = true;
      settings = {
        profile = [
          {
            name = "home";
            output = [
              {
                search = [
                  "m=Q27G4"
                  "s=18DQ9HA004518"
                  "v=AOC"
                ];
                enable = true;
                mode = "2560x1440@180Hz";
                position = "0,0";
              }
              {
                search = [
                  "m=K222HQL"
                  "s=T0EEE0058582"
                  "v=Acer Technologies"
                ];
                enable = true;
                mode = "1920x1080@60Hz";
                position = "2560,575";
              }
            ];
          }
          {
            name = "nulty";
            output = [
              {
                search = [
                  "m=GN246HL"
                  "s=LW3EE0058533"
                  "v=Acer Technologies"
                ];
                enable = true;
                mode = "1920x1080@144.001Hz";
                position = "0,0";
              }
            ];
          }
        ];
      };
    };

    gtk = {
      enable = true;
      colorScheme = "dark";

      theme = {
        package = pkgs.adw-gtk3;
        name = "Adw-gtk3-dark";
      };

      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };

      cursorTheme = {
        package = pkgs.volantes-cursors;
        name = "Volantes_light_cursors";
      };

      font = {
        name = "DejaVu Sans";
        package = pkgs.dejavu_fonts;
        size = 10;
      };
    };

    xdg.mime.enable = true;
    xdg.mimeApps = {
      enable = true;

      # Define your default applications for specific MIME types
      # https://mimetype.io/all-types
      defaultApplications = {
        "image/jpeg" = "org.kde.gwenview.desktop";
        "image/png" = "org.kde.gwenview.desktop";
        "image/gif" = "org.kde.gwenview.desktop";
        "image/tiff" = "org.kde.gwenview.desktop";
        "image/bmp" = "org.kde.gwenview.desktop";
        "image/webp" = "org.kde.gwenview.desktop";

        "application/zip" = "org.kde.ark.desktop";
        "application/gzip" = "org.kde.ark.desktop";
        "application/7z" = "org.kde.ark.desktop";
        "application/x-tar" = "org.kde.ark.desktop";
        "application/x-rar-compressed" = "org.kde.ark.desktop";
        "application/x-7z-compressed" = "org.kde.ark.desktop";
        "application/x-xz" = "org.kde.ark.desktop";

        "application/pdf" = "firefox.desktop";
        "text/html" = "firefox.desktop";

        "application/octet-stream" = "neovide.desktop";
      };
    };

    # polkit agent provides a GUI to interact with the polkit service, which allows applications to run with sudo privileges
    services.hyprpolkitagent.enable = true;

    # wallpaper
    services.swww.enable = true;

    programs.swaylock = {
      enable = true;
      # this needs PAM, so it should be installed using your OS package manager instead for best compatibility. Just set the package to null to not install swaylock.
      package = pkgs.swaylock;
      settings = { };
    };

    programs.anyrun = {
      enable = true;
      config = {
        x = {
          fraction = 0.5;
        };
        y = {
          fraction = 0.3;
        };
        width = {
          fraction = 0.3;
        };
        hideIcons = false;
        ignoreExclusiveZones = false;
        layer = "overlay";
        hidePluginInfo = false;
        closeOnClick = false;
        showResultsImmediately = true;
        maxEntries = null;
        plugins = [
          "${inputs.anyrun-swaywin.packages.${system}.default}/lib/libswaywin.so"
          "${pkgs.anyrun}/lib/libapplications.so"
          "${pkgs.anyrun}/lib/libsymbols.so"
        ];
      };
    };

    services.swaync = {
      enable = true;
    };

    programs.i3status-rust = {
      enable = true;
      bars = {
        default = {
          blocks = [
            {
              block = "disk_space";
              info_type = "available";
              interval = 60;
              path = "/";
              warning = 10.0;
            }
            {
              block = "memory";
              format = " $icon $mem_used_percents ";
            }
            {
              block = "nvidia_gpu";
              interval = 5;
            }
            {
              block = "cpu";
              interval = 5;
            }
            {
              block = "notify";
              format = " $icon {($notification_count.eng(w:1))|0} ";
              driver = "swaync";
              click = [
                {
                  button = "left";
                  action = "show";
                }
                {
                  button = "right";
                  action = "toggle_paused";
                }
              ];
            }
            # {
            #   block = "net";
            #   format = " $icon $device {$ssid|}";
            #   click = [
            #     {
            #       button = "left";
            #       cmd = "nm-connection-editor";
            #     }
            #   ];
            # }
            {
              block = "sound";
              click = [
                {
                  button = "left";
                  cmd = "pavucontrol";
                }
              ];
            }
            {
              block = "time";
              format = " $timestamp.datetime(f:'%a %d.%m %R') ";
              interval = 60;
            }
            {
              block = "custom";
              command = "echo ' ⏻ '";
              click = [
                {
                  button = "left";
                  cmd = "${pkgs.wlogout}/bin/wlogout";
                }
              ];
            }
          ];
        };
      };
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

    home.packages = with pkgs; [
      wdisplays
      pamixer
      flameshot

      pavucontrol
      networkmanagerapplet
    ];
  };
}
