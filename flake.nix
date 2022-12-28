{
  description = "Me systems flake";

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

    mkNixosConfig = {
      system,
      host,
      user,
      extraModules ? [],
    }: {};

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
            # home-manager.darwinModule
            # {
            #   home-manager.useGlobalPkgs = true;
            #   home-manager.useUserPackages = true;
            #   home-manager.users.${user}.username = "${user}";
            #   home-manager.users.${user}.homeDirectory = "${homePrefix system}/${user}";
            #   home-manager.users.${user} = import ./users/${user}/home.nix {
            #     inherit self pkgs;
            #     homePrefix = homePrefix system;
            #   };
            # }
          ]
          ++ extraModules;
        specialArgs = {inherit self pkgs system inputs;};
      };

    mkHomeConfig = {
      user,
      system,
      extraModules ? [],
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs system;
        modules =
          [
            ./modules/home-manager
            {
              home = {
                username = user;
                homeDirectory = "${homePrefix system}/${user}";
              };
            }
          ]
          ++ extraModules;
      };
  in {
    darwinConfigurations = {
      gus = mkDarwinConfig {
        system = "aarch64-darwin";
        host = "gus";
        user = "mo";
      };
    };

    nixosConfigurations = {
      monk = mkNixosConfig {
        system = "x86_64-linux";
        host = "monk";
        user = "mo";
      };
    };

    homeConfigurations = {
      "mo@gus" = mkHomeConfig {
        user = "mo";
        system = "aarch64-darwin";
        extraModules = [./modules/home-manager/karabiner.nix];
      };
      "mo@monk" = mkHomeConfig {
        user = "mo";
        system = "x86_64-linux";
        extraModules = [];
      };
    };
  };
}
