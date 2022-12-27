{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-22.11";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # To get yabai scripting addition to work with macos 13.1
    # ivar-nixpkgs-yabai-5_0_2.url = "github:IvarWithoutBones/nixpkgs?rev=27d6a8b410d9e5280d6e76692156dce5d9d6ef86";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: let
    isDarwin = system: (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);
    homePrefix = system:
      if isDarwin system
      then "/Users"
      else "/home";

    mkPkgs = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    mkDarwinConfig = {
      system,
      host,
      user,
      extraModules ? [],
    }:
      darwin.lib.darwinSystem rec {
        inherit system;
        pkgs = mkPkgs system;
        modules =
          [
            ./hosts/${host}
            ./modules/darwin
            home-manager.darwinModule
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mo = import ./users/${user}/home.nix {
                inherit self pkgs;
                homePrefix = homePrefix system;
              };
            }
          ]
          ++ extraModules;
        specialArgs = {inherit self pkgs system inputs;};
      };
  in {
    darwinConfigurations = {
      gus = mkDarwinConfig {
        system = "aarch64-darwin";
        host = "gus";
        user = "mo";
      };
    };
  };
}
