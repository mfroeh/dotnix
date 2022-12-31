{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../common.nix
    ./karabiner.nix
  ];
}
