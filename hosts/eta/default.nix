{ config, pkgs, lib, inputs, self, ... }: {
  imports = [
    ./hardware-configuration.nix
    "${inputs.nixos-m1}/nix/m1-support"
    "${self}/modules/nixos/xorg.nix"
    "${self}/modules/nixos/gnome.nix"
    "${self}/modules/nixos/remap.nix"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "eta";

  time.timeZone = "Europe/Stockholm";

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # Doesn't build currently
  # hardware.asahi.use4KPages = true;

  # Needed for trackpad
  services.xserver = {
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
  };

  # hardware.asahi.useExperimentalGPUDriver = true;
  hardware.asahi.addEdgeKernelConfig = true;
  hardware.opengl.enable = true;

  services.remap = {
    enable = true;
    capsToCtrl = true;
    swpBackslashBackspace = true;
  };
}
