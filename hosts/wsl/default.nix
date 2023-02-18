{ config, pkgs, lib, inputs, username, ... }: {
  imports = [ inputs.nixos-wsl.nixosModules.wsl ];

  networking.hostName = "wsl";

  time.timeZone = "Europe/Stockholm";

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.network.hostname = "wsl";
    defaultUser = "${username}";
    startMenuLaunchers = true;
  };
}
