{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.xwayland.enable = true;

  services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    gwenview
    okular
    oxygen
    khelpcenter
    konsole
    plasma-browser-integration
    print-manager
  ];
  programs.dconf.enable = true;
  qt5.platformTheme = "kde";
}
