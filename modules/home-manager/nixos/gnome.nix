{
  config,
  pkgs,
  lib,
  ...
}: {
  # Gnome extensions
  home.packages = with pkgs.gnomeExtensions; [
    pop-shell
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/desktop/background" = {
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = [
        "pop-shell@system76.com"
      ];
    };

    "org/gnome/shell/extensions/pop-shell" = {
      tile-by-default = true;
      active-hint = true;
      show-title = true;
      active-hint-border-radius = 5;
      gap-inner = 4;
      gap-outer = 4;
    };

    "org/gnome/mutter" = {
      edge-tiling = true;
    };

    # Configure according to https://github.com/pop-os/shell/blob/master_jammy/scripts/configure.sh
    "org/gnome/desktop/wm/keybindings" = {
      minimize = ["<Super>period"];
      maximize = [];
      unmaximize = [];
      switch-to-workspace-left = [];
      switch-to-workspace-right = [];
      move-to-monitor-up = [];
      move-to-monitor-down = [];
      move-to-monitor-left = [];
      move-to-monitor-right = [];
      move-to-workspace-down = [];
      move-to-workspace-up = [];
      switch-to-workspace-down = ["<Primary><Super>Down" "<Primary><Super>j"];
      switch-to-workspace-up = ["<Primary><Super>Up" "<Primary><Super>k"];
      toggle-maximized = ["<Super>f"];
      close = ["<Super>q"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      move-to-workspace-1 = ["<Super><Control>1"];
      move-to-workspace-2 = ["<Super><Control>2"];
      move-to-workspace-3 = ["<Super><Control>3"];
      move-to-workspace-4 = ["<Super><Control>4"];
      switch-input-source = [];
      switch-input-source-backward = [];
    };
    "org/gnome/shell/keybindings" = {
      open-application-menu = [];
      toggle-message-tray = ["<Super>v"];
      focus-active-notification = [];
      toggle-overview = [];
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      switch-to-application-6 = [];
      switch-to-application-7 = [];
      switch-to-application-8 = [];
      switch-to-application-9 = [];
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [];
      toggle-tiled-right = [];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
      screensaver = ["<Super>Escape"];
      rotate-video-lock-static = [];
      home = ["<Super>e"];
      email = [];
      www = [];
      terminal = [];
    };
    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>N";
      command = "${lib.meta.getExe pkgs.kitty}";
      name = "Open Kitty";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>space";
      command = "${lib.meta.getExe pkgs.rofi} -show combi -combi-modes 'window,drun' -modes combi -show-icons";
      name = "Open Rofi";
    };
  };
}
