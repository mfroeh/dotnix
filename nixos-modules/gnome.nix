{ config, pkgs, lib, ... }: {
  services.xserver.enable = true;
  programs.xwayland.enable = true;

  services.xserver.displayManager.gdm = {
    enable = true;
    settings = { debug.enable = true; };
    wayland = false;
  };

  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages =
    with pkgs.gnome; [
      gnome-maps
      cheese # webcam tool
      gnome-music
      gnome-terminal
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ];
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.dconf-editor
    gnome.gnome-screenshot
  ];
}
