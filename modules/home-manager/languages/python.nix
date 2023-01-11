{
  config,
  pkgs,
  lib,
  ...
}: let
  pythonPkgs = p: with p; [ numpy ];
in {
  home.packages = [ (pkgs.python3.withPackages pythonPkgs) ];
}
