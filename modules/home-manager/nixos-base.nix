{ config, pkgs, lib, ... }: {
  imports = [ ./base.nix ];

  home.packages = with pkgs;
    [ xorg.xwininfo wmctrl screenkey obsidian ltrace grive2 ]
    ++ lib.optionals (pkgs.system == "x86_64-linux") [ spotify google-chrome ]
    ++ lib.optionals (pkgs.system == "aarch64-linux") [ ];
}
