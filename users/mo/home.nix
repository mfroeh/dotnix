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
    "${self}/home-manager-modules/shell"
    "${self}/nixvim"

    "${self}/home-manager-modules/de/sway.nix"
    "${self}/home-manager-modules/gui/kde-apps.nix"
    "${self}/home-manager-modules/gui/neohtop.nix"
    "${self}/home-manager-modules/gui/firefox.nix"

    "${self}/home-manager-modules/zed.nix"

    "${self}/home-manager-modules/karabiner.nix"
  ];

  services.ssh-agent.enable = pkgs.stdenv.isLinux;

  programs.git = {
    enable = true;
    settings = {
      user.name = "mfroeh";
      user.email = "mfroeh0@pm.me";
      init.defaultBranch = "main";
    };
    lfs.enable = true;
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
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
      enable = pkgs.stdenv.isLinux;
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

  home.packages = with pkgs; [
    inputs.ngrams.defaultPackage.${system}
    # for random computations, generally install per project
    ghc
    leetcode-cli
    # (google-cloud-sdk.withExtraComponents (
    #   with google-cloud-sdk.components; [ gke-gcloud-auth-plugin ]
    # ))
  ];
}
