{ config, pkgs, lib, inputs, ... }: {
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    nvidiaPatches = true;
  };
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
