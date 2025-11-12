{ pkgs, config, ... }:
{
  programs.ghostty = {
    # until fixed on darwin
    enable = pkgs.stdenv.isLinux;
    package = config.lib.nixGL.wrap pkgs.ghostty;
    enableZshIntegration = true;
    settings = {
      theme = "Gruvbox Dark Hard";
      font-size = 12;
      font-family = "Iosevka Nerd Font Mono";
      app-notifications = false;
      confirm-close-surface = false;
    };
  };

  home.packages = [
    pkgs.nerd-fonts.iosevka
  ];
}
