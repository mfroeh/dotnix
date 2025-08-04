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
    # "${self}/home-manager-modules/de/hyprland"
    # "${self}/home-manager-modules/de/kde.nix"

    # gui apps
    "${self}/home-manager-modules/gui/bitwarden.nix"
    "${self}/home-manager-modules/gui/obs.nix"
    "${self}/home-manager-modules/gui/zathura.nix"

    # shell
    "${self}/home-manager-modules/shell"

    # editor
    "${self}/home-manager-modules/editor/zed.nix"

    # other
    "${self}/home-manager-modules/karabiner.nix"

    "${self}/nixvim"

    inputs.zen-browser.homeModules.twilight
    "${self}/home-manager-modules/gui/firefox.nix"
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

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };

  fonts.fontconfig.enable = true;

  home.file.".ideavimrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/jetbrains/.ideavimrc";

  home.packages =
    with pkgs;
    [
      inputs.ngrams.defaultPackage.${system}
      (google-cloud-sdk.withExtraComponents (
        with google-cloud-sdk.components; [ gke-gcloud-auth-plugin ]
      ))
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
    ];
}
