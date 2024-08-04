{ lib, pkgs, config, self, inputs, specialArgs, ... }:
with inputs;
{
imports = [
    "${self}/users/mo"
    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = specialArgs;
      home-manager.backupFileExtension = ".backup";
      home-manager.users.mo = import "${self}/users/mo/home.nix";
    }
];
system.stateVersion = 4;

networking.hostName = "xya";
networking.computerName = "xya";

services.nix-daemon.enable = true;
services.karabiner-elements.enable = true;
}
