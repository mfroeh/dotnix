{ pkgs, ... }: {
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  # Optional, hint electorn apps to use wayland (e.g. vscode)
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # todo: None of this seems to work 
  xdg.portal.enable = true;
}
