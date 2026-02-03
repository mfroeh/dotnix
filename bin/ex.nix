{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "ex";

  runtimeInputs = with pkgs; [
    gnutar
    unrar
    gzip
    unzip
    p7zip
    ncompress
    binutils
    zstd
  ];

  text = ''
    if [ ! -f "$1" ]; then
        echo "'$1' is not a valid file!"
        exit 1
    fi

    case "$1" in
        *.tar.bz2) tar xvjf "$1" ;;
        *.tar.gz)  tar xvzf "$1" ;;
        *.rar)     unrar x "$1"  ;;
        *.gz)      gunzip "$1"   ;;
        *.tar)     tar xvf "$1"  ;;
        *.tbz2)    tar xvjf "$1" ;;
        *.tgz)     tar xvzf "$1" ;;
        *.zip)     unzip "$1"    ;;
        *.Z)       uncompress "$1" ;;
        *.7z)      7z x "$1"     ;;
        *.deb)     ar x "$1"     ;;
        *.tar.xz)  tar xvf "$1"  ;;
        *.tar.zst) unzstd "$1"   ;;
        *) echo "don't know how to extract '$1'" && exit 1 ;;
    esac
  '';
}
