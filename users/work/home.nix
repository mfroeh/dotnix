{ lib, pkgs, ... }:
{
  home.stateVersion = "23.11";
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "RobotoMono" "Hack" ]; })
  ];
}
