{ config, pkgs, lib, ... }: {
  services.xserver = {
    enable = true;
    displayManager.lightdm = {
      enable = true;
      greeters.gtk = {
        theme.package = pkgs.zuki-themes;
        theme.name = "Zukitre";
      };
    };
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    windowManager.i3.enable = true;
    windowManager.i3.package = pkgs.i3-gaps;
  };

  programs.dconf.enable = true;
}
