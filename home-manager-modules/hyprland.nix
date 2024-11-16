{ self, pkgs, inputs, system, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
    systemd.variables = [ "--all" ];
    extraConfig = builtins.readFile ("${self}/config/hypr/hyprland.conf");

    plugins = with inputs.hyprland-plugins.packages.${system}; [
      hyprexpo
      hyprtrails
    ];
  };

  home.packages = with pkgs; [
    wofi
    inputs.launch.packages.${pkgs.system}.default

    # screenshot: grim -g "$(slurp)" - | wl-copy
    grim
    slurp
    wl-clipboard

    cinnamon.nemo
    imv

    pavucontrol
  ];

  # notifications # todo: test this
  services.mako = {
    enable = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  programs.waybar =
    {
      enable = true;
      style = ''
        * {
          font-size: 13px;
        }
        window#waybar {
          background: rgba(43, 48, 59, 0.8);
          border-bottom: 3px solid rgba(100, 114, 125, 0.5);
          color: white;
        }
        button {
            box-shadow: inset 0 -3px transparent;
            border: none;
            border-radius: 0;
        }
        button:hover {
          background: inherit;
          box-shadow: inset 0 -3px #ffffff;
        }
        #pulseaudio-slider trough, #backlight-slider trough {
            min-height: 10px;
            min-width: 80px;
          }
      '';
      settings = [{
        name = "bottom";
        layer = "top";
        position = "bottom";
        height = 30;
        modules-center = [ "wlr/taskbar" ];
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [ "tray" "hyprland/language" "pulseaudio/slider" "pulseaudio" "clock" "custom/power" ];
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
          format = " {}";
          format-us = "us";
          format-ru = "ru";
        };
        # todo: won't work
        tray = {
          icon-size = 13;
          spacing = 5;
        };
      }];
    };

  # configures wlogout
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        text = "Lock (l)";
        action = "hyprlock";
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
        action = "hyprctl dispatch exit";
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

  # configures hyprlock
  programs.hyprlock = {
    # the NixOS option `programs.hyprlock.enable` is required for hyprlock to work as it needs PAM access
    enable = true;
    extraConfig = builtins.readFile ("${self}/config/hypr/hyprlock.conf");
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";

      preload = [
        "${self}/config/wallpapers/mirroring.png"
      ];

      wallpaper = [
        ", ${self}/config/wallpapers/mirroring.png"
      ];
    };
  };
}

