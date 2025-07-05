{ pkgs, config, ... }:
{
  programs.zed-editor = {
    enable = true;
    extraPackages = with pkgs; [
      nixd
      vscode-json-languageserver
      rust-analyzer

      golangci-lint
      golangci-lint-langserver
    ];
  };

  xdg.configFile."zed/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/zed/settings.json";
  xdg.configFile."zed/keymap.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/zed/keymap.json";
}
