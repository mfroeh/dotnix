{ pkgs, ... }: {
  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      clock_format     = "%R";
      background_color = "0xff202020";
      foreground_color = "0xffa8a8a8";
    };
    extraConfig = '''';
  };
}