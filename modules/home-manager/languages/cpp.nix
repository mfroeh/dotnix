{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    valgrind
    cmake
    # clang_14
    # clang-tools_14
    gcc
    gnumake
    gdb
    ddd
  ];
}
