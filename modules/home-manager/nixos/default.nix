{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./i3.nix ./rofi.nix];

  home.packages = with pkgs;
    [
      xorg.xwininfo
      screenkey
      obsidian
    ]
    ++ lib.optionals (pkgs.system == "x86_64-linux") [spotify obsidian google-chrome bitwarden];

  programs = {
    chromium = {
      enable = true;
    };
  };
}
