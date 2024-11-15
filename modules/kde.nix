{ ... }: {
  services.desktopManager.plasma6 = {
    enable = true;
    # Enable Qt 5 integration (theming, etc). Disable for a pure Qt 6 system.
    enableQt5Integration = false;
  };
  qt.platformTheme = "kde";
  programs.xwayland.enable = true;

  # optional, hint electron apps to use wayland (e.g. vscode)
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
