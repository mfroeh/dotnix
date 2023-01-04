{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [./hardware-configuration.nix "${inputs.nixos-m1}/nix/m1-support"];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

# Remove if issue during rebuild
  hardware.asahi.pkgsSystem = "x86_64-linux";

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # Doesn't build currently
  # hardware.asahi.use4KPages = true;

  # Needed for trackpad
  services.xserver.libinput.enable = true;

  networking.hostName = "eta";

  time.timeZone = "Europe/Stockholm";
}
