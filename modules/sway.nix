{ ... }:
{
  services.displayManager = {
    enable = true;
    sddm = {
      enable = false;
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
