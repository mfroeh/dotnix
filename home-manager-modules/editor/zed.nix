{ pkgs, config, ... }:
{
  programs.zed-editor = {
    enable = true;
  };

  xdg.configFile."zed/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/zed/settings.json";
  xdg.configFile."zed/keymap.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/zed/keymap.json";

  home.packages = with pkgs; [
    # nix
    nixd
    nixfmt-rfc-style

    # json
    vscode-json-languageserver

    # rust
    (rust-bin.selectLatestNightlyWith (
      toolchain:
      toolchain.default.override {
        extensions = [ "rust-analyzer" ];
      }
    ))

    # go
    gopls
    # golangci-lint
    golangci-lint-langserver

    # c++
    clang-tools

    # toml
    taplo
  ];
}
