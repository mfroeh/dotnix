{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    valgrind
    cmake
    gcc12
    gnumake
    gdb
    ddd
    meson
    ninja

    clang-tools_14
    cmake-language-server
  ];
}
