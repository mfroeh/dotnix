{ lib, pkgs, self, ... }:
{
  imports = [
    "${self}/home-manager-modules/kitty.nix"
    "${self}/home-manager-modules/tmux.nix"
    "${self}/home-manager-modules/zsh.nix"
    "${self}/home-manager-modules/nvim.nix"
    "${self}/home-manager-modules/fzf.nix"
    "${self}/home-manager-modules/vscode.nix"
    "${self}/home-manager-modules/karabiner.nix"
  ];

  # ] ++ lib.optionals pkgs.stdenv.isLinux [ 
  # "${self}/home-manager-modules/kde.nix"
  #"${self}/home-manager-modules/hyperwm.nix"
  # ]

  home.stateVersion = "24.11";

  programs.git = {
    enable = true;
    userName = "mfroeh";
    userEmail = "mfroeh0@pm.me";
    aliases = {
      s = "status";
      co = "checkout";
      b = "branch";
      aa = "add -A";
      p = "push";
    };
    extraConfig = {
      init.defaultBranch = "master";
    };
    diff-so-fancy.enable = true;
  };

  programs.lazygit = {
    enable = true;
    settings = { };
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    coreutils-full
    devenv

    rustup

    discord

    # fun
    neofetch
    tt

    # archivers
    zip
    unzip
    rar

    # utils
    ripgrep
    fd
    dust # du in rust
    just

    # nix
    nix-tree
    nix-output-monitor # `nom` is an alias for `nix` with detailled log output

    which
    glow
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    teams-for-linux
    skypeforlinux
  ];

  programs.zathura.enable = true;
  programs.bat.enable = true;

  programs.btop.enable = true;

  programs.obs-studio = {
    enable = pkgs.stdenv.isLinux;
    plugins = [ pkgs.obs-studio-plugins.obs-backgroundremoval ];
  };
}
