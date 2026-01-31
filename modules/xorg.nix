{ ... }:
{
  # this has no effect in wayland
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    xkb.options = "terminate:ctrl_alt_bksp";
    # delay is ms until auto repeat activates
    autoRepeatDelay = 250;
    # interval between automatically generated keypresses
    autoRepeatInterval = 50;
  };
}
