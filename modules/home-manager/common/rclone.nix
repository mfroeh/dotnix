{ config, pkgs, lib, ... }:
let
  dir = "${config.home.homeDirectory}/google-drive";
in
{
  # Maybe configuration in the future
  home.packages = [ pkgs.rclone ];

  systemd.user.services.google-drive-mount = {
    Unit = {
      Description = "mount google-drive dir";
      After = [ "network-online.target" ];
    };
    Install.WantedBy = [ "multi-user.target" ];
    Service = {
      ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${dir}";
      ExecStart = ''
        ${lib.meta.getExe pkgs.rclone} mount gdrive: ${dir};
      '';
      ExecStop = "/run/wrappers/bin/fusermount -u ${dir}";
      Type = "notify";
      Restart = "always";
      RestartSec = "10s";
    };
  };
}
