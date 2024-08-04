{ lib, pkgs, config, self, inputs, specialArgs, ... }:
with inputs;
{
  imports = [
    inputs.mac-app-util.darwinModules.default
    "${self}/users/mo"
    home-manager.darwinModules.home-manager
    {
      home-manager.sharedModules =
        [ mac-app-util.homeManagerModules.default ];
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = specialArgs;
      home-manager.backupFileExtension = ".backup";
      home-manager.users.mo = import "${self}/users/mo/home.nix";
    }
  ];

  # otherwise nix-darwin wont chsh for users
  programs.zsh.enable = true;

  system.stateVersion = 4;

  networking.hostName = "xya";
  networking.computerName = "xya";

  services.nix-daemon.enable = true;
  services.karabiner-elements.enable = true;
}
