{
  config,
  pkgs,
  lib,
  ...
}: {
  services.picom = {
    enable = true;
  };
}
