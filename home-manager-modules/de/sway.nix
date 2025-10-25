{ self, pkgs, ... }:
let
  mod = "Mod4";
  anyrun-toggle = pkgs.writeShellScriptBin "anyrun-toggle" ''
    if pgrep wofi > /dev/null; then
      pkill anyrun
    else
      exec ${pkgs.anyrun}/bin/anyrun
    fi
  '';
in
{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      startup = [
        {
          command = "${pkgs.swtchr}/bin/swtchrd";
          always = true;
        }
        {
          # force restart to ensure update
          command = "systemctl --user restart shikane.service";
          always = true;
        }
        {
          command = "${pkgs.swww}/bin/swww img ${self}/config/wallpapers/autumn-1.jpg";
          always = true;
        }
        { command = "ghostty"; }
        { command = "firefox"; }
      ];
      terminal = "${pkgs.ghostty}/bin/ghostty";
      assigns = {
        "0" = [ { app_id = "ghostty"; } ];
        "2" = [ { app_id = "firefox"; } ];
      };
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

        "${mod}+0" = "workspace number 0";
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 3";
        "${mod}+Return" = "workspace number 0";

        "${mod}+Shift+0" = "move container to workspace number 0";
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 3";

        "${mod}+f" = "fullscreen toggle";
        "${mod}+v" = "floating toggle";

        "${mod}+d" = "exec anyrun";

        "${mod}+e" = "exec ${pkgs.kdePackages.dolphin}/bin/dolphin";
        "${mod}+Mod1+l" = "exec swaylock";

        "${mod}+Shift+q" = "kill focused";
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 5";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 5";
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
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
            app_id = "wofi";
          };
          command = "floating enable, border none";
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
      ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark";
    };

    iconTheme = {
      package = pkgs.gruvbox-dark-icons-gtk;
      name = "oomox-gruvbox-dark";
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
    defaultApplications = {
      "image/jpeg" = "org.geeqie.Geeqie.desktop";
      "image/png" = "org.geeqie.Geeqie.desktop";
      "image/gif" = "org.geeqie.Geeqie.desktop";
      "image/tiff" = "org.geeqie.Geeqie.desktop";
      "image/bmp" = "org.geeqie.Geeqie.desktop";
      "image/webp" = "org.geeqie.Geeqie.desktop";
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
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libsymbols.so"
      ];
    };
  };

  home.packages = with pkgs; [
    wdisplays
    pamixer
    kdePackages.dolphin
    geeqie
  ];
}
