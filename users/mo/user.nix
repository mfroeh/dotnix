{
  config,
  pkgs,
  lib,
  ...
}: let
  isLinux = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
in
  with lib; {
    users.users.mo = mkMerge [
      {
        description = "mfroeh";
        shell = pkgs.fish;
      }
      (mkIf isLinux {
        home = "/home/mo";
        isNormalUser = true;
        extraGroups = ["networkmanager" "wheel" "audio" "video"];
        initialPassword = "";
      })
      (mkIf isDarwin {
        home = "/Users/mo";
      })
    ];
  }
