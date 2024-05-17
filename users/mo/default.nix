{ config, pkgs, lib, ... }:
with lib;
{
  users.users.mo = mkMerge [
    {
      description = "mfroeh";
      shell = pkgs.zsh;
    }
    (mkIf pkgs.stdenv.isLinux {
      home = "/home/mo";
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "audio" "video" "vboxusers" ];
      initialPassword = "";
    })
    (mkIf pkgs.stdenv.isDarwin { home = "/Users/mo"; })
  ];
}
