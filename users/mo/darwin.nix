{ config, pkgs, lib, ... }: 
{
  users.users.mo = {
    description = "mfroeh";
    home = "/Users/mo";
    shell = pkgs.fish;
  };
}