{ config, pkgs, lib, self, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    "${self}/modules/nixos/xorg.nix"
    "${self}/modules/nixos/gnome.nix"
    "${self}/modules/nixos/remap.nix"
    "${self}/modules/nixos/virtualization.nix"
    inputs.hyprland.nixosModules.default
    # "${self}/modules/nixos/hyperwm.nix"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lambda";

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";
  time.hardwareClockInLocalTime = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;

  # Virtualbox
  virtualisation.virtualbox.host.enable = true;

  services.remap = { enable = true; wm = "gnome"; };
}
