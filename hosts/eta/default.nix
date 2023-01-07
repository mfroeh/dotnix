{
  config,
  pkgs,
  lib,
  inputs,
  self,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    "${inputs.nixos-m1}/nix/m1-support"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "eta";

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # Doesn't build currently
  # hardware.asahi.use4KPages = true;

  # Needed for trackpad
  services.xserver = {
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
    dpi = 200;
  };

  # set wallpaper
  fetchBackground = {
    enable = true;
    url = "${self}/config/wallpaper.png";
  };

  hardware.asahi.useExperimentalGPUDriver = true;
  hardware.opengl.enable = true;

  time.timeZone = "Europe/Stockholm";

  services.remap = {
    enable = true;
    capsToCtrl = true;
    swpBackslashBackspace = true;
  };
}
