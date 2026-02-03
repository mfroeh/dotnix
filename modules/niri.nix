{ pkgs, inputs, ... }:
{
  imports = [ inputs.niri.nixosModules.niri ];
  services.displayManager = {
    enable = true;
    gdm = {
      enable = true;
      wayland = true;
    };
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  environment.systemPackages = [ pkgs.xwayland-satellite ];

  # https://nixos.wiki/wiki/Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
