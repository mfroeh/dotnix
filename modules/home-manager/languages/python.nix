{ config, pkgs, lib, ... }:
let pythonPkgs = p: with p; [ numpy scipy ipykernel matplotlib pandas ];
in { home.packages = [ (pkgs.python3.withPackages pythonPkgs) ]; }
