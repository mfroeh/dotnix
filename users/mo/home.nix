{ lib, pkgs, self, config, ... }:
{
  imports = [
    "${self}/home-manager-modules/kitty.nix"
    "${self}/home-manager-modules/tmux.nix"
    "${self}/home-manager-modules/zsh.nix"
    "${self}/home-manager-modules/nvim.nix"
    "${self}/home-manager-modules/fzf.nix"
    "${self}/home-manager-modules/vscode.nix"
    "${self}/home-manager-modules/zed.nix"

    "${self}/home-manager-modules/karabiner.nix"
    "${self}/home-manager-modules/hyprland.nix"
  ];

  home.stateVersion = "24.11";

  services.ssh-agent.enable = true;

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

    zoom-us

    rustup

    zed-editor.fhs
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
  ] ++ lib.optionals pkgs.stdenv.isLinux [ ];

  programs.zathura.enable = true;
  programs.bat.enable = true;

  programs.btop.enable = true;

  programs.obs-studio = {
    enable = pkgs.stdenv.isLinux;
    plugins = [ pkgs.obs-studio-plugins.obs-backgroundremoval ];
  };

  home.file."${config.xdg.configHome}/wallpapers" = {
    source = "${self}/config/wallpapers";
    recursive = true;
  };
}
