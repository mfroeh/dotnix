{ config, pkgs, lib, self, platform, ... }:
let extension = "org/gnome/shell/extensions";
in {
  # Gnome extensions
  home.packages = with pkgs.gnomeExtensions; [
    pop-shell
    space-bar
    system-monitor
    appindicator
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-animations = false;
      enable-hot-corners = false;
    };

    "org/gnome/desktop/background" = {
      picture-uri = "file:///${self}/config/wallpapers/light.png";
      picture-uri-dark = "file:///${self}/config/wallpapers/night.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///${self}/config/wallpapers/night.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = [
        "pop-shell@system76.com"
        "space-bar@luchrioh"
        "system-monitor@paradoxxx.zero.gmail.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
      ];
    };

    "${extension}/system-monitor" = {
      icon-display = false;
      cpu-display = true;
      cpu-style = "digit";
      cpu-show-text = false;
      memory-display = true;
      memory-style = "digit";
      memory-show-text = false;
      net-display = false;
      net-style = "digit";
      net-show-text = false;
      thermal-display = true;
      thermal-style = "digit";
      thermal-show-text = false;
    };

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "neovide.desktop:1"
        "code.desktop:1"
        "org.gnome.Nautilus.desktop:2"
        "chromium-browser.desktop:3"
        "google-chrome.desktop:3"
        "virtualbox.desktop:5"
        "spotify.desktop:6"
      ];
    };

    "org/gnome/shell/extensions/space-bar/behavior" = {
      show-empty-workspaces = true;
      smart-workspace-names = false;
      scroll-wheel = "panel";
    };

    "org/gnome/shell/extensions/space-bar/shortcuts" = {
      enable-activate-workspace-shortcuts = false;
      enable-move-to-workspace-shortcuts = false;
      activate-empty-key = [ ];
      open-menu = [ ];
      activate-previous-key = [ ];
    };

    "org/gnome/shell/extensions/pop-shell" = {
      tile-by-default = true;
      active-hint = true;
      show-title = true;
      active-hint-border-radius = 5;
      smart-gaps = false;
      # gap-inner = "uint32 4";
      # gap-outer = "uint32 4";
    };

    "org/gnome/desktop/wm/preferences" = {
      dynamic-workspaces = false;
      num-workspaces = 6;
      workspace-names = [ "0::dev" "1::" "2::web" "3::fun" "4::" "5::social" ];
    };

    # "org/gnome/mutter" = {
    #   edge-tiling = true;
    # };

    "org/gnome/mutter" = { overlay-key = "Super_R"; };

    # Configure according to https://github.com/pop-os/shell/blob/master_jammy/scripts/configure.sh
    "org/gnome/desktop/wm/keybindings" = {
      minimize = [ "<Super>period" ];
      maximize = [ ];
      unmaximize = [ ];
      switch-to-workspace-left = [ ];
      switch-to-workspace-right = [ ];
      move-to-monitor-up = [ ];
      move-to-monitor-down = [ ];
      move-to-monitor-left = [ ];
      move-to-monitor-right = [ ];
      move-to-workspace-down = [ ];
      move-to-workspace-up = [ ];
      switch-to-workspace-down = [ "<Primary><Super>Down" "<Primary><Super>j" ];
      switch-to-workspace-up = [ "<Primary><Super>Up" "<Primary><Super>k" ];
      toggle-maximized = [ "<Super>f" ];
      toggle-fullscreen = [ "<Super><Control>f" ];
      close = [ "<Super>q" ];
      switch-to-workspace-1 = [ "<Super>0" ];
      switch-to-workspace-2 = [ "<Super>1" ];
      switch-to-workspace-3 = [ "<Super>2" ];
      switch-to-workspace-4 = [ "<Super>3" ];
      switch-to-workspace-5 = [ "<Super>4" ];
      switch-to-workspace-6 = [ "<Super>5" ];
      move-to-workspace-1 = [ "<Super><Control>0" ];
      move-to-workspace-2 = [ "<Super><Control>1" ];
      move-to-workspace-3 = [ "<Super><Control>2" ];
      move-to-workspace-4 = [ "<Super><Control>3" ];
      move-to-workspace-5 = [ "<Super><Control>4" ];
      move-to-workspace-6 = [ "<Super><Control>5" ];
      switch-input-source = [ ];
      switch-input-source-backward = [ ];
    };
    "org/gnome/shell/keybindings" = {
      open-application-menu = [ ];
      toggle-message-tray = [ "<Super>v" ];
      focus-active-notification = [ ];
      toggle-overview = [ ];
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
      switch-to-application-5 = [ ];
      switch-to-application-6 = [ ];
      switch-to-application-7 = [ ];
      switch-to-application-8 = [ ];
      switch-to-application-9 = [ ];
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ ];
      toggle-tiled-right = [ ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
      screensaver = [ "<Super>Escape" ];
      rotate-video-lock-static = [ ];
      home = [ "<Super>e" ];
      email = [ ];
      www = [ ];
      terminal = [ ];
      logout = [ "<Shift><Super>e" ];
    };
    "org/gnome/mutter/wayland/keybindings" = { restore-shortcuts = [ ]; };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
      {
        binding = "<Super>apostrophe";
        command = "${lib.meta.getExe
          (if platform.x86_64-linux then pkgs.kitty else pkgs.alacritty)}";
        name = "Open terminal";
      };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
      {
        binding = "<Super>space";
        command = "${
            lib.meta.getExe pkgs.rofi
          } -show combi -combi-modes 'window,drun' -modes combi -show-icons";
        name = "Open Rofi";
      };
  };
}
