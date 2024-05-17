{...}: {
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;
}
