{ self, pkgs, homePrefix, ... }:
let
  mkMod = name: "${self}/modules/home-manager/${name}.nix";
in {
  home.username = "mo";
  home.homeDirectory = "${homePrefix}/mo";

  # TODO: Remove karabiner-elements from here
  imports = (map mkMod [ "git" "fish" "vim" "kitty" "vscode" "tldr" "karabiner-elements" ]);

  home.packages = with pkgs; [ obsidian nixfmt ];

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.home-manager.enable = true;
  home.stateVersion = "22.11";
}
