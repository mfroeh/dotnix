{
  description = "Me system(s) flake :)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

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
      url = "github:hyprwm/Hyprland?ref=v0.45.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins?ref=v0.45.0";
      inputs.hyprland.follows = "hyprland";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    launch.url = "github:mfroeh/launch";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nix-darwin, ... }@inputs:
    let
      mkPkgs = { system, nixpkgs }:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ ];
        };

      mkSpecialArgs = { system }: {
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
          modules = [ ./modules/nix.nix "${self}/hosts/lambda" ];
          specialArgs = mkSpecialArgs { inherit system; };
        };
      };

      darwinConfigurations = {
        xya = nix-darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          pkgs = mkPkgs { inherit system nixpkgs; };
          modules = [ ./modules/nix.nix "${self}/hosts/xya" ];
          specialArgs = mkSpecialArgs { inherit system; };
        };
      };
    };
}
