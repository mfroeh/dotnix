{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    gcc
    valgrind
  ];
}
