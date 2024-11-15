{ ... }: {
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    xkb.options = "terminate:ctrl_alt_bksp";
    # delay is ms until auto repeat activates
    autoRepeatDelay = 150;
    # interval between automatically generated keypresses
    autoRepeatInterval = 50;
  };

  services.displayManager.sddm.enable = true;
}
