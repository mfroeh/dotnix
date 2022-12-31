{config, pkgs, lib, ...}: 
let
  cliPkgs = with pkgs; [ git ripgrep fd ];
  guiPkgs = with pkgs; [ ];
  editors = with pkgs; [ neovim vscode ];
in {
  imports = [../common.nix ./system-defaults.nix ./brew.nix ./yabai.nix ./skhd.nix ./spacebar.nix ./wallpaper.nix];

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  services.karabiner-elements.enable = true;

  environment.variables = {
    EDITOR = "nvim";
  };

  programs.fish.enable = true;
  environment.shells = with pkgs; [fish];
  environment.systemPackages = cliPkgs ++ guiPkgs ++ editors ++ (with pkgs; []);

  system.stateVersion = 4;
}
