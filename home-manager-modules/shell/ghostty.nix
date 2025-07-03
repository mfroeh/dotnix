{ pkgs, ... }:
{
  programs.ghostty = {
    # until fixed on darwin
    enable = pkgs.stdenv.isLinux;
    enableZshIntegration = true;
    settings = {
      theme = "nightfox";
      font-size = 12;
      font-family = "Hack Nerd Font Mono";
      app-notifications = false;
    };
  };

  home.packages = [ pkgs.nerd-fonts.hack ];
}
