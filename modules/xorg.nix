{ pkgs, ... }:
{
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

  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland = {
        enable = true;
      };
    };
  };

  # this makes sway show up in SDDM, the configuration is done using home manager
  programs.sway.enable = true;
  # this enabled swaylock to actually unlock a session
  security.pam.services.swaylock = { };

  security.polkit.enable = true;
}
