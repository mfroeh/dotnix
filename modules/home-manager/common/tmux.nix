{ config, pkgs, lib, ... }:
# TODO: Use C-f to jump to directory and to complete if we typed anything
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    prefix = "C-a";
    # keyMode = "vi";
    # sensibleOnTop = true;
    # escapeTime = 0;
  };
}
