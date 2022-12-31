{
  config,
  pkgs,
  lib,
  ...
} : {
  users.users.mo = {
    description = "mfroeh";
    isNormalUser = true;
    home = "/home/mo";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    initialPassword = "";
    shell = pkgs.fish;
  };
}