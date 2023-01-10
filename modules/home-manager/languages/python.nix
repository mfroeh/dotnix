{
  config,
  pkgs,
  lib,
  ...
}: let
  pythonPkgs = p:
    with pkgs; [
    ];
in {
  home.packages = with pkgs; [
    python3.withPackages
    pythonPkgs
  ];
}
