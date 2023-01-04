{
  config,
  pkgs,
  lib,
  ...
}: {
  services.skhd = {
    enable = true;
    skhdConfig = ''
      ## Anything concerning spaces/applications uses the cmd key
      # Space Navigation: cmd - {1, 2, 3, 4, ..., 0}
      cmd - 1 : yabai -m space --focus 1
      cmd - 2 : yabai -m space --focus 2
      cmd - 3 : yabai -m space --focus 3
      cmd - 4 : yabai -m space --focus 4
      cmd - 5 : yabai -m space --focus 5
      cmd - 6 : yabai -m space --focus 6
      cmd - 7 : yabai -m space --focus 7
      cmd - 8 : yabai -m space --focus 8
      cmd - 9 : yabai -m space --focus 9
      cmd - 0 : yabai -m space --focus recent

      # Moving windows between spaces: cmd + ctrl - {1, 2, 3, 4, p, n }
      cmd + ctrl - 1 : yabai -m window --space 1 && yabai -m space --focus 1
      cmd + ctrl - 2 : yabai -m window --space 2 && yabai -m space --focus 2
      cmd + ctrl - 3 : yabai -m window --space 3 && yabai -m space --focus 3
      cmd + ctrl - 4 : yabai -m window --space 4 && yabai -m space --focus 4
      cmd + ctrl - 5 : yabai -m window --space 5 && yabai -m space --focus 5
      cmd + ctrl - 6 : yabai -m window --space 6 && yabai -m space --focus 6
      cmd + ctrl - 7 : yabai -m window --space 7 && yabai -m space --focus 7
      cmd + ctrl - 8 : yabai -m window --space 8 && yabai -m space --focus 8
      cmd + ctrl - 9 : yabai -m window --space 9 && yabai -m space --focus 9

      # Open/focus applications
      cmd - return : open /etc/profiles/per-user/$USER/bin/kitty
      cmd - e      : open /Applications/Emacs.app

      ## Anything concerning window movement uses the alt key
      # Window Navigation: alt - {h, j, k, l, 0}
      alt - h    : yabai -m window --focus west
      alt - j    : yabai -m window --focus south
      alt - k    : yabai -m window --focus north
      alt - l    : yabai -m window --focus east
      alt - 0  : yabai -m window --focus recent

      # Moving windows in spaces: alt + ctrl - {h, j, k, l}
      alt + ctrl - h : yabai -m window --swap west
      alt + ctrl - j : yabai -m window --swap south
      alt + ctrl - k : yabai -m window --swap north
      alt + ctrl - l : yabai -m window --swap east

      # Resize windows: alt + shift - {h, j, k, l}
      alt + shift - h    : yabai -m window --resize left:-50:0;  yabai -m window --resize right:-50:0
      alt + shift - j    : yabai -m window --resize bottom:0:50; yabai -m window --resize top:0:50
      alt + shift - k    : yabai -m window --resize top:0:-50;   yabai -m window --resize bottom:0:-50
      alt + shift - l    : yabai -m window --resize right:50:0;  yabai -m window --resize left:50:0

      # Rotate tree
      alt - r : yabai -m space --rotate 90

      # Equalize size of windows
      alt - e : yabai -m space --balance

      # Enable / Disable gaps in current workspace
      alt - g : yabai -m space --toggle padding; yabai -m space --toggle gap

      # Make window zoom to fullscreen
      # TODO: Sent this to sketchybar
      alt - f : yabai -m window --toggle zoom-fullscreen; sketchybar --trigger window_focus

      # Make floating window fill screen
      shift + alt - up     : yabai -m window --grid 1:1:0:0:1:1

      # Make floating window fill left-half of screen
      shift + alt - left   : yabai -m window --grid 1:2:0:0:1:1

      # Make floating window fill right-half of screen
      shift + alt - right  : yabai -m window --grid 1:2:1:0:1:1
    '';
  };
}
