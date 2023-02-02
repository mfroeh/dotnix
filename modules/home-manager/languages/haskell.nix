{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ ghc haskell-language-server ];
}
