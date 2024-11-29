{ lib, pkgs, self, config, ... }:
{
  imports = [
    "${self}/home-manager-modules/kitty.nix"
    "${self}/home-manager-modules/tmux.nix"
    "${self}/home-manager-modules/zsh.nix"
    "${self}/home-manager-modules/nvim.nix"
    # "${self}/home-manager-modules/nixvim.nix"
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

  programs.btop = {
    enable = true;
    package = pkgs.btop.override { cudaSupport = true; };
    settings = {
      color_theme = "gruvbox_dark_v2";
      theme_background = true;
      vim_keys = true;
      update_ms = 500;
    };
  };

  programs.obs-studio = {
    enable = pkgs.stdenv.isLinux;
    plugins = [ pkgs.obs-studio-plugins.obs-backgroundremoval ];
  };

  home.file."${config.xdg.configHome}/wallpapers" = {
    source = "${self}/config/wallpapers";
    recursive = true;
  };

  programs.yazi = {
    enable = true;
    keymap = {
      manager.prepend_keymap = [
        {
          on = "y";
          run = [ ''shell 'for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list' --confirm'' "yank" ];
        }
      ];
    };
  };

  # this doesn't work with Dolphin atlesat
  xdg.enable = true;
  xdg.mimeApps = rec {
    enable = true;
    defaultApplications = 
      {
        "application/pdf" = ["org.kde.okular.desktop"];
        "text/html" = ["google-chrome.desktop"];
        "image/png" = ["org.kde.gwenview.desktop"];
      };
    associations.added = defaultApplications;
  };
}
