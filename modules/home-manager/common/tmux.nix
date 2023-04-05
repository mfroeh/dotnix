{ config, pkgs, lib, ... }:
# TODO: Use C-f to jump to directory and to complete if we typed anything
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";

    clock24 = true;
    prefix = "C-a";
    keyMode = "vi";
    escapeTime = 0;

    plugins = with pkgs.tmuxPlugins; [
      # nord
    ];
  };
}
