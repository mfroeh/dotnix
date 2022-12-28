{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.rbw = {
    enable = true;
    settings.email = "mfroeh0@protonmail.com";
  };
}
