{
  self,
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cliPkgs = with pkgs; [git ripgrep fd alejandra neofetch];
  guiPkgs = with pkgs; [discord];
  otherPkgs = with pkgs; [];
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
    yt-dlp.enable = true;
  };

  home.packages = cliPkgs ++ guiPkgs ++ otherPkgs;
}
