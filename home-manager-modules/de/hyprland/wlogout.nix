{ ... }:
{
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
}
