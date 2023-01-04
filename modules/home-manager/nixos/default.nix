{
  config,
  pkgs,
  lib,
  ...
}: let
  cliPkgs = with pkgs; [xorg.xwininfo];
  # guiPkgs = with pkgs; [spotify google-chrome bitwarden obsidian];
guiPkgs = with pkgs; [ screenkey ];
  otherPkgs = with pkgs; [];
in {
  imports = [../common.nix ./i3.nix ./rofi.nix];

  home.packages = cliPkgs ++ guiPkgs ++ otherPkgs;
}
