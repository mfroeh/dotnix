{ config, pkgs, lib, ... }:
with lib;
{
  users.users.work = mkMerge [
    {
      description = "work";
      shell = pkgs.zsh;
    }
    (mkIf pkgs.stdenv.isLinux {
      home = "/home/work";
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "audio" "video" "vboxusers" ];
      initialPassword = "";
    })
    (mkIf pkgs.stdenv.isDarwin { home = "/Users/work"; })
  ];
}
