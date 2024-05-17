{ config, pkgs, lib, ... }: {
  programs.zathura = {
    enable = true;
    options = {
      default-bg = "#000000";
      default-fg = "#FFFFFF";
      selection-timeout = 10000000;
    };
    mappings = { };
    extraConfig = "";
  };
}
