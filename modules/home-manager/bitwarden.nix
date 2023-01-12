{ config, pkgs, lib, ... }: {
  home.packages =
    lib.optionals (pkgs.system == "x86_64-linux") [ pkgs.bitwarden ];

  # Bitwarden cli
  programs.rbw = {
    enable = true;
    settings.email = "mfroeh0@protonmail.com";
  };
}
