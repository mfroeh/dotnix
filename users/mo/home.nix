{
  self,
  pkgs,
  homePrefix,
  ...
}: let
  mkMod = name: "${self}/modules/home-manager/${name}.nix";

  shellPkgs = with pkgs; [
    ripgrep
    fd
    tree
    htop-vim
    alejandra
  ];

  cliPkgs = with pkgs; [
  ];

  guiPkgs = with pkgs; [
    obsidian
  ];
in {
  home.username = "mo";
  home.homeDirectory = "${homePrefix}/mo";

  # TODO: Remove karabiner-elements from here
  imports = map mkMod ["git" "fish" "nvim" "kitty" "vscode" "tldr" "rbw" "karabiner-elements"];

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = ["--cmd j"];
  };

  home.packages =
    guiPkgs
    ++ shellPkgs
    ++ cliPkgs
    ++ [
    ];

  # Let home-manager install and mange itself
  programs.home-manager.enable = true;
  home.stateVersion = "22.11";
}
