{
  config,
  pkgs,
  lib,
  extraPkgs,
  system,
  ...
}: {
  imports = [
    ./cli.nix
    ./gui.nix
    ./kitty.nix
    ./fish.nix
    ./nvim.nix
    ./vscode.nix
    (
      if (lib.hasSuffix "darwin" system)
      then ./darwin
      else ./nixos
    )
  ];

  home.packages = extraPkgs;

  # Let home-manager install and mange itself
  programs.home-manager.enable = true;
  home.stateVersion = "22.11";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
