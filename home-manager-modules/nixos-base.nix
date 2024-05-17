{ config, pkgs, lib, isLinux, ... }: {
  imports = [ ./base.nix ];

  home.packages = with pkgs; []
    ++ lib.optionals (isLinux) [ xorg.xwininfo wmctrl screenkey obsidian ltrace spotify google-chrome ];
}
