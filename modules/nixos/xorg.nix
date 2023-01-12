{ config
, pkgs
, lib
, ...
}: {
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "";
  services.xserver.autoRepeatDelay = 200;
  services.xserver.autoRepeatInterval = 25;
}
