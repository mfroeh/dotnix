{ config, pkgs, lib, ... }: {
  services.picom = {
    enable = true;
    vSync = true;
    inactiveOpacity = 0.95;
    fade = true;
    fadeDelta = 5;
    shadow = true;
  };
}
