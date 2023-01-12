{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ rustc cargo rust-analyzer ];
}
