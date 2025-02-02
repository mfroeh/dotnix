{
  description = "Me system(s) flake :)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # fix nix installed .app not appearing in spotlight
    mac-app-util.url = "github:hraban/mac-app-util";

    hyprland = {
      url = "github:hyprwm/Hyprland?ref=v0.47.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins/014003b2bd3744dfabb8c2c20a80e89f721be238"; # 0.47.0
      inputs.hyprland.follows = "hyprland";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker.url = "github:abenz1267/walker";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nix-darwin,
      home-manager,
      ...
    }@inputs:
    let
      mkPkgs =
        { system, nixpkgs }:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.allowUnfreePredicate = _: true;
          # https://github.com/LnL7/nix-darwin/issues/1041
          overlays = [
            (self: super: {
              karabiner-elements = super.karabiner-elements.overrideAttrs (old: {
                version = "14.13.0";

                src = super.fetchurl {
                  inherit (old.src) url;
                  hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
                };
              });
            })
          ];
        };

      mkSpecialArgs =
        { system }:
        {
          inherit self inputs system;
          pkgsStable = mkPkgs {
            inherit system;
            nixpkgs = nixpkgs-stable;
          };
        };
    in
    {
      nixosConfigurations = {
        lambda = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = mkPkgs { inherit system nixpkgs; };
          modules = [
            ./modules/nix.nix
            "${self}/hosts/lambda"
          ];
          specialArgs = mkSpecialArgs { inherit system; };
        };
      };

      darwinConfigurations = {
        xya = nix-darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          pkgs = mkPkgs { inherit system nixpkgs; };
          modules = [
            ./modules/nix.nix
            "${self}/hosts/xya"
          ];
          specialArgs = mkSpecialArgs { inherit system; };
        };
      };

      homeConfigurations = {
        "mo@lambda" =
          let
            system = "x86_64-linux";
          in
          home-manager.lib.homeManagerConfiguration {
            pkgs = mkPkgs { inherit nixpkgs system; };
            modules = [
              {
                home.stateVersion = "24.11";
                programs.home-manager.enable = true;
                home = {
                  username = "mo";
                  homeDirectory = "/home/mo";
                };
              }
              "${self}/users/mo/home.nix"
            ];
            extraSpecialArgs = mkSpecialArgs { inherit system; };
          };
      };
    };
}
