{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./hardware-configuration.nix];
  networking.hostName = "herc";

  time.timeZone = "Europe/Stockholm";
  time.hardwareClockInLocalTime = true;

  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl.enable = true;
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DVI-D-0 --primary --mode 1920x1080 --rotate normal --rate 144
  '';

  # services.autorandr = {
  #   enable = true;
  #   profiles = {
  #       germany = {
  #         fingerprint = {
  #           DVI-D-O = "00ffffffffffff000472f90233034070041b010380351e78ca57e0a5544f9d26125054bfef80714f8140818081c081009500b300d1c0023a801871382d40582c4500132b2100001e000000fd0038901ea021000a202020202020000000fc00474e323436484c0a2020202020000000ff004c57334545303035383533330a015902010400fe5b80a07038354030203500132a2100001a866f80a07038404030203500132a2100001afc7e80887038124018203500132a2100001e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c7";
  #         };
  #         config = {
  #           DVI-D-0 = {
  #             enable = true;
  #             mode = "1920x1080";
  #             primary = true;
  #             rate = "144.00";
  #           };
  #         };
  #       };
  #     };
  # };
}
