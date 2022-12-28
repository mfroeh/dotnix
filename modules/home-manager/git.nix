{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "mfroeh";
    userEmail = "mfroeh0@pm.me";
    aliases = {
      s = "status";
    };
    diff-so-fancy.enable = true;
  };
}
