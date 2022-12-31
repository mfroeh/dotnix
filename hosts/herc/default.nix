{...}: {
  imports = [./hardware-configuration.nix];
  networking.hostName = "herc";

  time.timeZone = "Europe/Stockholm";
  time.hardwareClockInLocalTime = true;

  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl.enable = true;
}
