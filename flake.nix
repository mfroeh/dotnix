{
  description = "Me system(s) flake :)";


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    xremap-flake.url = "github:xremap/nix-flake";
    xremap-flake.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    hyprswitch.url = "github:h3rmt/hyprswitch/release";

    plasma-manager =
      {
        url = "github:pjones/plasma-manager";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "home-manager";
      };

    launch.url = "github:mfroeh/launch";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , home-manager
    , xremap-flake
    , neovim-nightly-overlay
    , hyprland
    , ...
    } @ inputs:
    let
      homeDir = system: if nixpkgs.stdenv.isDarwin system then "/Users" else "/home";

      mkPkgs = { system, nixpkgs }:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ ];
        };

      mkSpecialArgs = { system }: {
        inherit self inputs system;
        pkgsStable = mkPkgs { inherit system; nixpkgs = nixpkgs-stable; };
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
    };
}
