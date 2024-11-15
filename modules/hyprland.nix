{ pkgs, inputs, system, ... }: {
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;

    xwayland.enable = true;
  };

  # Optional, hint electron apps to use wayland (e.g. vscode)
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
