{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

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

  in {
    darwinConfigurations = {
        gus = darwin.lib.darwinSystem rec {
            system = "aarch64-darwin";
            pkgs = mkPkgs system;
            modules = [
                ./hosts/gus
                {
                  environment.systemPackages = with pkgs; [htop];
                }

                home-manager.darwinModule {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.mo = import ./users/mo.nix { inherit self pkgs system inputs; };
                }
            ];
        };
    };
  };
}
