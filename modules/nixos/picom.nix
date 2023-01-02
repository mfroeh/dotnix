{
  config,
  pkgs,
  lib,
  ...
}: {
  services.picom = {
    enable = true;
    vSync = true;
    inactiveOpacity = 0.95;
    fade = true;
    fadeDelta = 5;
    shadow = true;

    settings = {
      blur = {
        method = "gaussian";
        size = 10;
        deviation = 5.0;
      };
    };
  };
}
