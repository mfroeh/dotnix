{
  lib,
  pkgs,
  self,
  inputs,
  system,
  config,
  ...
}:
{
  imports = [
    # desktop environment
    "${self}/home-manager-modules/de/sway.nix"

    # gui apps
    "${self}/home-manager-modules/gui/bitwarden.nix"
    "${self}/home-manager-modules/gui/obs.nix"
    "${self}/home-manager-modules/gui/zathura.nix"
    "${self}/home-manager-modules/gui/firefox.nix"

    # shell
    "${self}/home-manager-modules/shell"

    # editor
    "${self}/home-manager-modules/editor/zed.nix"
    "${self}/nixvim"

    # other
    "${self}/home-manager-modules/karabiner.nix"
  ];

  services.ssh-agent.enable = pkgs.stdenv.isLinux;

  programs.git = {
    enable = true;
    userName = "mfroeh";
    userEmail = "mfroeh0@pm.me";
    extraConfig = {
      init.defaultBranch = "main";
    };
    delta.enable = true;
    delta.options = {
      line-numbers = true;
      decorations = {
        commit-decoration-style = "bold yellow box ul";
        file-decoration-style = "none";
        file-style = "bold yellow ul";
      };
      features = "decorations";
    };
  };

  fonts.fontconfig.enable = true;

  home.file.".ideavimrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/jetbrains/.ideavimrc";

  # just sets some env variables
  xdg = {
    enable = true;
    stateHome = "${config.home.homeDirectory}/.local/state";
    dataHome = "${config.home.homeDirectory}/.local/share";
    configHome = "${config.home.homeDirectory}/.config";
    cacheHome = "${config.home.homeDirectory}/.cache";

    # sets XDG_DESKTOP_DIR, ...
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      publicShare = "${config.home.homeDirectory}/Public";
      templates = "${config.home.homeDirectory}/Templates";
      videos = "${config.home.homeDirectory}/Videos";
    };
  };

  home.packages =
    with pkgs;
    [
      inputs.ngrams.defaultPackage.${system}
      (google-cloud-sdk.withExtraComponents (
        with google-cloud-sdk.components; [ gke-gcloud-auth-plugin ]
      ))
      leetcode-cli
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      # gui
      discord
      vlc
      gimp
      blender
      ardour
      youtube-music
      bitwarden-desktop
      tidal-hifi
      (jetbrains.goland.override { jdk = pkgs.openjdk21; })
      (jetbrains.rust-rover.override { jdk = pkgs.openjdk21; })

      lunar-client

      # e.g. ld, readelf,
      binutils
    ];
}
