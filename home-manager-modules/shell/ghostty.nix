{ pkgs, ... }:
{
  programs.ghostty = {
    # until fixed on darwin
    enable = pkgs.stdenv.isLinux;
    enableZshIntegration = true;
    settings = {
      theme = "GruvboxDarkHard";
      font-size = 12;
      app-notifications = false;
    };
  };
}
