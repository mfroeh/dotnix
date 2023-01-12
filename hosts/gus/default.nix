{ config
, pkgs
, lib
, self
, ...
}: {
  imports = [
    "${self}/modules/darwin/brew.nix"
    "${self}/modules/darwin/yabai.nix"
    "${self}/modules/darwin/shkd.nix"
  ];

  networking.hostName = "gus";
}
