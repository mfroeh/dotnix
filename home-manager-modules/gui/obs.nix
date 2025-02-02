{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = pkgs.stdenv.isLinux;
    plugins = [ pkgs.obs-studio-plugins.obs-backgroundremoval ];
  };
}
