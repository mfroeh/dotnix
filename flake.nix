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
        modules =
          [./modules/nixos-base.nix ./users/${user}.nix ./hosts/${host}]
          ++ [xremap-flake.nixosModules.default hyprland.nixosModules.default] # Flake modules
          ++ extraModules;
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
            ./modules/darwin-base.nix
            ./hosts/${host}
            ./users/${user}.nix
          ]
          ++ extraModules;
        specialArgs = {inherit self system inputs;};
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
        extraSpecialArgs = {inherit self system inputs extraPkgs;};
      };
  in {
    darwinConfigurations = {
      gus = mkDarwinConfig {
        system = "aarch64-darwin";
        host = "gus";
        user = "mo";
        extraModules = [
          ./modules/darwin/brew.nix
          ./modules/darwin/yabai.nix
          ./modules/darwin/shkd.nix
        ];
      };
    };

    nixosConfigurations = {
      herc = mkNixosConfig {
        system = "x86_64-linux";
        host = "herc";
        user = "mo";
        extraModules = [
          ./modules/nixos/xfce-i3.nix
          ./modules/nixos/picom.nix
          ./modules/nixos/remap.nix
        ];
      };
      eta = mkNixosConfig {
        system = "aarch64-linux";
        host = "eta";
        user = "mo";
        extraModules = [
          ./modules/nixos/xfce-i3.nix
          ./modules/nixos/remap.nix
        ];
      };
    };

    homeConfigurations = {
      "mo@gus" = mkHomeConfig {
        user = "mo";
        system = "aarch64-darwin";
        extraModules = [];
        extraPkgs = [];
      };
      "mo@herc" = mkHomeConfig {
        user = "mo";
        system = "x86_64-linux";
        extraModules = [];
        extraPkgs = [];
      };
      "mo@eta" = mkHomeConfig {
        user = "mo";
        system = "aarch64-linux";
        extraModules = [];
        extraPkgs = [];
      };
    };
  };
}
