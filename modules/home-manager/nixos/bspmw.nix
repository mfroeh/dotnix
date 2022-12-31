{
  config,
  pkgs,
  lib,
  ...
}: {
  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
      "DVI-D-0" = [
        "random"
        "web"
        "term"
        "dev"
        "social"
        "music"
      ];
    };
    settings = {
      split_ratio = 0.5;
      border_width = 2;
      window_gap = 10;
    };
    rules = {
      "google-chrome" = {
        desktop = "^web";
        follow = true;
      };
    };
  };
}
