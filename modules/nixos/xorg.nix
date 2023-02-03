{ config, pkgs, lib, ... }: {
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "";
  services.xserver.autoRepeatDelay = 150;
  services.xserver.autoRepeatInterval = 50;
}
