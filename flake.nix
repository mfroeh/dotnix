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
  };

  outputs = inputs @ { self, nixpkgs, darwin, home-manager, ... }: 
  let
    isDarwin = system: (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);
    homePrefix = system: if isDarwin system then "/Users" else "/home";

    mkPkgs = system: import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    mkDarwinConfig = { system, host, user, extraModules ? [], }:
      darwin.lib.darwinSystem rec {
        inherit system;
        pkgs = mkPkgs system;
        modules = [
          ./hosts/${host}
          ./modules/darwin
          home-manager.darwinModule {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mo = import ./users/${user} { 
              inherit self pkgs; 
              homePrefix = homePrefix system; 
            };
          }
        ] ++ extraModules;
        # specialArgs = {inherit self pkgs system inputs nixpkgs;};
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
