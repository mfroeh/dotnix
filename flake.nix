{
  description = "Me systems flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-22.11";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-m1.url = "github:tpwrules/nixos-m1";
    nixos-m1.flake = false;

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    xremap-flake.url = "github:xremap/nix-flake";
    xremap-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    xremap-flake,
    hyprland,
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
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        pkgs = mkPkgs system;
        modules = [./hosts/${host} ./modules/nixos ./users/${user}/user.nix] ++ extraModules;
        specialArgs = {inherit self system inputs;};
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
            ./users/${user}/user.nix
          ]
          ++ extraModules;
        specialArgs = {inherit self pkgs system inputs;};
      };

    mkHomeConfig = {
      user,
      system,
      extraModules ? [],
      extraPkgs ? [],
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
        extraSpecialArgs = {inherit extraPkgs system;};
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
      herc = mkNixosConfig {
        system = "x86_64-linux";
        host = "herc";
        user = "mo";
        extraModules = [xremap-flake.nixosModules.default];
      };
      eta = mkNixosConfig {
        system = "aarch64-linux";
        host = "eta";
        user = "mo";
        extraModules = [xremap-flake.nixosModules.default];
      };
    };

    homeConfigurations = {
      "mo@gus" = mkHomeConfig {
        user = "mo";
        system = "aarch64-darwin";
        extraModules = [];
      };
      "mo@herc" = mkHomeConfig {
        user = "mo";
        system = "x86_64-linux";
        extraModules = [];
      };
      "mo@eta" = mkHomeConfig {
        user = "mo";
        system = "aarch64-linux";
        extraModules = [];
      };
    };
  };
}
