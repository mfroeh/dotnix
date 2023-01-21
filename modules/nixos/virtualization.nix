{ config, pkgs, lib, ... }: {
  virtualisation.virtualbox = { host.enable = true; };
}
