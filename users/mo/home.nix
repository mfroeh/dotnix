{
  lib,
  pkgs,
  self,
  inputs,
  system,
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
      init.defaultBranch = "main";
    };
    diff-so-fancy.enable = true;
  };

  fonts.fontconfig.enable = true;

  home.packages =
    with pkgs;
    [
      rustup
      inputs.ngrams.defaultPackage.${system}
    ] ++ lib.optional pkgs.stdenv.isLinux [
      # gui
      zoom-us
      google-chrome
      discord
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
    ];
}
