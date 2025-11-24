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
    # shell
    "${self}/home-manager-modules/shell"

    # editor
    "${self}/home-manager-modules/editor/zed.nix"
    "${self}/nixvim"
  ];

  # nixGL = {
  #   packages = inputs.nixgl.packages;
  #   defaultWrapper = "nvidiaPrime";
  # };
  #

  services.ssh-agent.enable = pkgs.stdenv.isLinux;

  programs.git = {
    enable = true;
    userName = "Moritz Froehlich";
    userEmail = "moritz.froehlich@freiheit.com";
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

  home.packages = [ ] ++ lib.optionals pkgs.stdenv.isLinux [ ];
}
