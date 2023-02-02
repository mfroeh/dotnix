{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ sumneko-lua-language-server stylua ];
}
