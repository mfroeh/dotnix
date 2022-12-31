{
  self,
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  homeDir = config.home.homeDirectory;

  # Shared gui packages
  guiPkgs = with pkgs; [
    obsidian
  ];

  # Shared cli packages
  cliPkgs = with pkgs; [
    ripgrep
    fd

    alejandra
  ];

  # x86_64-linux only packages
  linuxPkgs = with pkgs; [
    spotify
    google-chrome
  ];

  # aarch64-darwin only packages
  darwinPkgs = with pkgs; [
  ];

in {
  imports = [
    ./kitty.nix
    ./fish.nix
    ./fzf.nix

    ./nvim.nix
    ./vscode.nix

    ./git.nix
    ./rbw.nix
    ./tldr.nix
    ./vscode.nix
  ];

  # Let home-manager install and mange itself
  programs.home-manager.enable = true;
  home.stateVersion = "22.11";
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs = {
    bat.enable = true;
    lsd = {
      enable = true;
      enableAliases = true;
    };
    zoxide = {
      enable = true;
      options = ["--cmd j "];
    };
    less.enable = true;

    man.enable = true;
    htop = {
      enable = true;
      package = pkgs.htop-vim;
    };
    zathura.enable = true;

    # Try out!
    nix-index.enable = true;
    yt-dlp.enable = true;
  };

  home.packages = with pkgs;
    [
    ]
    ++ cliPkgs ++ guiPkgs ++ (if stdenv.isLinux then linuxPkgs else darwinPkgs);
}
