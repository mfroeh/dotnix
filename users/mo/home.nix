{
  lib,
  pkgs,
  self,
  config,
  ...
}:
{
  imports = [
    # desktop environment
    "${self}/home-manager-modules/de/hyprland"

    # gui
    "${self}/home-manager-modules/gui/bitwarden.nix"

    # shell
    "${self}/home-manager-modules/shell"

    # editor
    "${self}/home-manager-modules/editor/zed.nix"
    "${self}/home-manager-modules/editor/nvim.nix"

    # other
    "${self}/home-manager-modules/karabiner.nix"
  ];

  services.ssh-agent.enable = pkgs.stdenv.isLinux;

  programs.git = {
    enable = true;
    userName = "mfroeh";
    userEmail = "mfroeh0@pm.me";
    extraConfig = {
      init.defaultBranch = "master";
    };
    diff-so-fancy.enable = true;
  };

  fonts.fontconfig.enable = true;

  home.packages =
    with pkgs;
    [
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

      # gui
      google-chrome
      spotify
      vlc
      zotero
      gimp
      blender
      teams-for-linux
      skypeforlinux
      ardour
      youtube-music
      bitwarden-desktop

      lunar-client
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [ ];

  programs.zathura.enable = true;
  programs.bat.enable = true;

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
          run = [
            ''shell 'for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list' --confirm''
            "yank"
          ];
        }
      ];
    };
  };

  # this doesn't work with Dolphin atlesat
  xdg.enable = pkgs.stdenv.isLinux;
  xdg.mimeApps = rec {
    enable = pkgs.stdenv.isLinux;
    defaultApplications = {
      "application/pdf" = [ "org.kde.okular.desktop" ];
      "text/html" = [ "google-chrome.desktop" ];
      "image/png" = [ "org.kde.gwenview.desktop" ];
    };
    associations.added = defaultApplications;
  };
}
