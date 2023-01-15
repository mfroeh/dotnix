{ config, pkgs, lib, ... }:
let
  mountdir = "${config.home.homeDirectory}/google-drive";
in
{
  home.packages = [ pkgs.rclone ];

  systemd.user.services.google-drive-mount = {
    Unit = {
      Description = "mount google-drive";
      After = [ "network-online.target" ];
    };
    Install.WantedBy = [ "default.target" ];
    Service = {
      ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${mountdir}";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount gdrive: ${mountdir}
      '';
      ExecStop = "/run/wrappers/bin/fusermount -u ${mountdir}";
      ExecStopPost = "/run/current-system/sw/bin/rmdir -p ${mountdir}";
      Type = "notify";
      Restart = "always";
      RestartSec = "10s";
      Environment = [ "PATH=/run/wrappers/bin/" ];
    };
  };
}
