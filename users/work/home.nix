{
  lib,
  pkgs,
  self,
  config,
  inputs,
  ...
}:
{
  imports = [
    # desktop environment
    "${self}/home-manager-modules/de/hyprland"

    # gui apps
    "${self}/home-manager-modules/gui/bitwarden.nix"
    "${self}/home-manager-modules/gui/obs.nix"
    "${self}/home-manager-modules/gui/zathura.nix"

    # shell
    "${self}/home-manager-modules/shell"
    # until we get nixGL to work :s
    "${self}/old-modules/kitty.nix"

    # editor
    "${self}/home-manager-modules/editor/zed.nix"
    "${self}/home-manager-modules/editor/nvim.nix"
  ];

  nixGL = {
    packages = inputs.nixgl.packages;
    defaultWrapper = "nvidiaPrime";
  };

  services.ssh-agent.enable = pkgs.stdenv.isLinux;

  programs.git = {
    enable = true;
    userName = "Moritz Froehlich";
    userEmail = "moritz.froehlich@freiheit.com";
    extraConfig = {
      init.defaultBranch = "master";
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

  home.packages =
    with pkgs;
    [
      inputs.nixglhost.defaultPackage.${pkgs.system}
      # pkgs.nixgl.nixGLDefault
      # zoom-us
      # rustup
      # discord

      # gui
      # google-chrome
      # spotify
      # vlc
      # zotero
      # gimp
      # blender
      # teams-for-linux
      # skypeforlinux
      # ardour
      # youtube-music
      # bitwarden-desktop

      # lunar-client
      # pkgs.nixgl.auto.nixGLDefault
      # pkgs.nixgl.auto.nixGLNvidia
      # pkgs.mesa
    ] # todo
    ++ lib.optionals pkgs.stdenv.isLinux [ ];

  # todo: this doesn't work with Dolphin atlesat
  # xdg.enable = pkgs.stdenv.isLinux;
  # xdg.mimeApps = rec {
  #   enable = pkgs.stdenv.isLinux;
  #   defaultApplications = {
  #     "application/pdf" = [ "org.kde.okular.desktop" ];
  #     "text/html" = [ "google-chrome.desktop" ];
  #     "image/png" = [ "org.kde.gwenview.desktop" ];
  #   };
  #   associations.added = defaultApplications;
  # };
}
