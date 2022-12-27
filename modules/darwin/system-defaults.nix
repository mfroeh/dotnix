{pkgs, ...}: {
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
      # Allow quitting via ⌘ + Q; doing so will also hide desktop icons
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

    spaces = {
      spans-displays = false;
    };

    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };

    NSGlobalDomain = {
      # Theme
      AppleInterfaceStyle = "Dark";

      # Use key repeat over press and hold
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 1;
      InitialKeyRepeat = 20;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.trackpad.enableSecondaryClick" = true;

      # Full keyboard access
      AppleKeyboardUIMode = 3;

      # Use function keys as media keys
      "com.apple.keyboard.fnState" = false;

      # Disable opening and closing window animations
      NSAutomaticWindowAnimationsEnabled = false;

      NSScrollAnimationEnabled = false;
      NSWindowResizeTime = 0.001;

      # Size of the symbols on the left menu in Finder
      NSTableViewDefaultSizeMode = 1;

      # Hide the menu bar
      _HIHideMenuBar = true;
    };
  };
}
