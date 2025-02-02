{ pkgs, config, ... }:
{
  programs.zed-editor = {
    enable = true;
  };

  xdg.configFile."zed/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/zed/settings.json";
  xdg.configFile."zed/keymap.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/zed/keymap.json";

  # lsps, formatters, etc.
  home.packages = with pkgs; [
    # nix
    nixd
    nixfmt-rfc-style

    # zed installs language servers through node if it can
    nodejs_23
  ];
}
