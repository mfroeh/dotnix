{
  config,
  pkgs,
  lib,
  self,
  inputs,
  ...
}: {
  imports = [../common.nix ./xremap.nix ./picom.nix ./xfce-i3.nix];

  system.stateVersion = "22.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.autoRepeatDelay = 250;
  services.xserver.autoRepeatInterval = 50;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  virtualisation.virtualbox.host.enable = true;

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  programs.fish.enable = true;
  environment.shells = with pkgs; [fish];

  environment.systemPackages = with pkgs; [vim git];
}
