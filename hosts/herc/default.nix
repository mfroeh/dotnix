{
  config,
  pkgs,
  lib,
  self,
  ...
}: {
  imports = [./hardware-configuration.nix];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "herc";

  time.timeZone = "Europe/Stockholm";
  time.hardwareClockInLocalTime = true;

  virtualisation.virtualbox.host.enable = true;

  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl.enable = true;
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DVI-D-0 --primary --mode 1920x1080 --rotate normal --rate 144
  '';

  services.remap = {
    enable = true;
  };
}
