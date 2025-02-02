{ pkgs, ... }:
{
  # https://bitwarden.com/help/keyboard-shortcuts/
  home.packages = with pkgs; [ bitwarden-desktop ];

  # configure systemd user service
  systemd.user.services.bitwarden = {
    Unit = {
      Description = "Bitwarden Password Manager";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.bitwarden-desktop}/bin/bitwarden";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
