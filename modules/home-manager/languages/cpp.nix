{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    valgrind
    clang_14
    clang-tools_14
    # gcc
  ];
}
