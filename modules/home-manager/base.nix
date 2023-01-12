{ config
, pkgs
, lib
, ...
}: {
  imports = [
    ./cli.nix
    ./kitty.nix
    ./fish.nix

    ./nvim.nix
    ./vscode.nix

    ./bitwarden.nix
  ];

  # Let home-manager install and mange itself
  programs.home-manager.enable = true;
  home.stateVersion = "22.11";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
