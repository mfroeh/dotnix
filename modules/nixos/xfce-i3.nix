{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./thunar.nix];

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager = {
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    windowManager.i3.enable = true;
    windowManager.i3.package = pkgs.i3-gaps;
  };
}
