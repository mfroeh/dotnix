{
  config,
  pkgs,
  lib,
  self,
  inputs,
  ...
}: 
{
  imports = [../common.nix];

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

  services.xserver.layout = "us";

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
    windowManager.i3.configFile = "${self}/config/i3/config";
    desktopManager.xfce.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  virtualisation.virtualbox.host.enable = true;

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
    # KDEWM = "${lib.meta.getExe pkgs.bspwm}/bin/bspwm";
  };

  programs.fish.enable = true;
  environment.shells = with pkgs; [fish];

  environment.systemPackages = with pkgs; [ vim git ];
}
