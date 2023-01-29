{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    valgrind
    cmake
    # clang_14
    # clang-tools_14
    gcc12
    gnumake
    gdb
    ddd
    meson
    ninja
  ];
}
