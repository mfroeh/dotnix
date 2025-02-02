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

  wayland.windowManager.hyprland = {
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
    [
      # screenshot: grim -g "$(slurp)" - | wl-copy
      grim
      slurp
      wl-clipboard

      pavucontrol
    ]
    ++ (with pkgs.kdePackages; [
      dolphin
      gwenview
      okular
    ]);

  # configures hyprlock
  programs.hyprlock = {
    # the NixOS option `programs.hyprlock.enable` is required for hyprlock to work as it needs PAM access
    enable = true;
    extraConfig = builtins.readFile ("${self}/config/hypr/hyprlock.conf");
  };

  services.hyprpaper = {
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
