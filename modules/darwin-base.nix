{ config, pkgs, lib, ... }: {
  imports = [ ./base.nix ];

  system.stateVersion = 4;

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  services.karabiner-elements.enable = true;

  system.defaults = {
    # Disable application quarantine message
    LaunchServices.LSQuarantine = false;

    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.0;
      mru-spaces = false;
      showhidden = true;
      expose-animation-duration = 0.0;
      expose-group-by-app = false;
      mineffect = "scale";
      minimize-to-application = false;
      show-recents = false;
      static-only = true;
      tilesize = 48;

      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };

    finder = {
      QuitMenuItem = true;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      CreateDesktop = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = false;
    };

    screencapture = {
      location = "/tmp";
      type = "jpg";
    };

    spaces = { spans-displays = false; };

    trackpad = {
      # Tap to click
      Clicking = true;
    };

    NSGlobalDomain = {
      # Use key repeat over press and hold
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 1;
      InitialKeyRepeat = 15;

      # Full keyboard access
      AppleKeyboardUIMode = 3;

      # Disable opening and closing window animations
      NSAutomaticWindowAnimationsEnabled = false;

      NSScrollAnimationEnabled = false;
      NSWindowResizeTime = 1.0e-3;

      # Size of the symbols on the left menu in Finder
      NSTableViewDefaultSizeMode = 1;

      # Hide the menu bar
      _HIHideMenuBar = true;
    };
  };
}
