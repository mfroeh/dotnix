{
  self,
  pkgs,
  inputs,
  system,
  lib,
  ...
}:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
    systemd.variables = [ "--all" ];
    extraConfig = builtins.readFile "${self}/config/hypr/hyprland.conf";

    plugins = with inputs.hyprland-plugins.packages.${system}; [
      hyprexpo
      hyprtrails
    ];
  };

  home.packages =
    with pkgs;
    lib.optionals pkgs.stdenv.isLinux [
      # screenshot: grim -g "$(slurp)" - | wl-copy
      grim
      slurp
      wl-clipboard

      pavucontrol

      kdePackages.dolphin
      kdePackages.gwenview
      kdePackages.okular
    ];

  # configures hyprlock
  programs.hyprlock = lib.mkIf pkgs.stdenv.isLinux {
    # the NixOS option `programs.hyprlock.enable` is required for hyprlock to work as it needs PAM access
    enable = true;
    extraConfig = builtins.readFile ("${self}/config/hypr/hyprlock.conf");
  };

  services.hyprpaper = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    settings = rec {
      ipc = "on";

      wallpaper = [
        ",${self}/config/wallpapers/mirroring.png"
        ",${self}/config/wallpapers/pink.png"
      ];

      preload = [
        "${self}/config/wallpapers/mirroring.png"
        "${self}/config/wallpapers/pink.png"
      ];
    };
  };
}
