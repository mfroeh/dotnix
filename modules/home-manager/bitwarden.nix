{ config, pkgs, lib, platform, ... }: {
  home.packages = lib.optionals platform.x86_64-linux [ pkgs.bitwarden ];

  # Bitwarden cli
  programs.rbw = {
    enable = true;
    settings.email = "mfroeh0@protonmail.com";
  };
}
