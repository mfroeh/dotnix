{ pkgs, config, ... }:
{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isLinux then pkgs.ghostty else pkgs.ghostty-bin;
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
