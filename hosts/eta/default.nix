{ config, pkgs, lib, inputs, self, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-apple-silicon.nixosModules.default
    "${self}/modules/nixos/xorg.nix"
    "${self}/modules/nixos/gnome.nix"
    "${self}/modules/nixos/remap.nix"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "eta";

  time.timeZone = "Europe/Stockholm";

  hardware.asahi = {
    # use4KPages = true; # doesn't build currently
    peripheralFirmwareDirectory = ./firmware;
    addEdgeKernelConfig = true;
    useExperimentalGPUDriver = true;
  };
  hardware.opengl.enable = true;

  # Needed for trackpad
  services.xserver = {
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
  };

  services.remap = {
    enable = true;
    wm = "gnome";
    capsToCtrl = true;
    swpBackslashBackspace = true;
  };
}
