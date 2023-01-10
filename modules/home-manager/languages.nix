{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # c/c++
    gcc
    valgrind
    # clang
    # clang-tools

    # rust
    rustc
    cargo
    rust-analyzer

    # nix
    nil
  ];
}
