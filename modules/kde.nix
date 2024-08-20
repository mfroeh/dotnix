{ ... }: {
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6 = {
    enable = true;
    # Enable Qt 5 integration (theming, etc). Disable for a pure Qt 6 system.
    enableQt5Integration = false;
  };
  qt.platformTheme = "kde";
  programs.xwayland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
