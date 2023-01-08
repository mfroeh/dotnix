{
  description = "Me systems flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-22.11";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-m1.url = "github:tpwrules/nixos-m1";
    nixos-m1.flake = false;

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # hyprland.url = "github:hyprwm/Hyprland";

    xremap-flake.url = "github:xremap/nix-flake";
    xremap-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    stable,
    darwin,
    home-manager,
    xremap-flake,
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
      username,
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem rec {
        inherit system;
        pkgs = mkPkgs system;
        modules =
          [./modules/nixos-base.nix ./users/${username}.nix ./hosts/${host}]
          ++ [xremap-flake.nixosModules.default] # Flake modules
          ++ extraModules;
        specialArgs = {inherit self system username inputs;};
      };

    mkDarwinConfig = {
      system,
      host,
      username,
      extraModules ? [],
    }:
      darwin.lib.darwinSystem rec {
        inherit system;
        pkgs = mkPkgs system;
        modules =
          [
            ./modules/darwin-base.nix
            ./hosts/${host}
            ./users/${username}.nix
          ]
          ++ extraModules;
        specialArgs = {inherit self system username inputs;};
      };

    mkHomeConfig = {
      username,
      system,
      extraModules ? [],
      extraPkgs ? pkgs: [],
    }:
      home-manager.lib.homeManagerConfiguration rec {
        pkgs = mkPkgs system;
        modules =
          [
            ./modules/home-manager
            {
              home = {
                inherit username;
                homeDirectory = "${homePrefix system}/${username}";
                packages = extraPkgs pkgs;
              };
            }
          ]
          ++ extraModules;
        extraSpecialArgs = {inherit self system username inputs;};
      };
  in {
    darwinConfigurations = {
      gus = mkDarwinConfig {
        system = "aarch64-darwin";
        host = "gus";
        username = "mo";
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
        username = "mo";
        extraModules = [
          ./modules/nixos/xfce-i3.nix
          ./modules/nixos/picom.nix
          ./modules/nixos/remap.nix
        ];
      };
      eta = mkNixosConfig {
        system = "aarch64-linux";
        host = "eta";
        username = "mo";
        extraModules = [
          ./modules/nixos/gnome.nix
          # ./modules/nixos/xfce-i3.nix
          # ./modules/nixos/picom.nix
          ./modules/nixos/remap.nix
          # ./modules/nixos/wallpaper.nix
        ];
      };
      lambda = mkNixosConfig {
        system = "x86_64-linux";
        host = "lambda";
        username = "mo";
        extraModules = [
          ./modules/nixos/gnome.nix
          ./modules/nixos/remap.nix
        ];
      };
    };

    homeConfigurations = {
      "mo@gus" = mkHomeConfig {
        username = "mo";
        system = "aarch64-darwin";
        extraModules = [];
      };
      "mo@herc" = mkHomeConfig {
        username = "mo";
        system = "x86_64-linux";
        extraModules = [];
      };
      "mo@eta" = mkHomeConfig {
        username = "mo";
        system = "aarch64-linux";
        extraModules = [];
        extraPkgs = pkgs: with pkgs; [alacritty];
      };
      "mo@lambda" = mkHomeConfig {
        username = "mo";
        system = "x86_64-linux";
        extraModules = [];
        extraPkgs = pkgs: with pkgs; [];
      };
    };
  };
}
