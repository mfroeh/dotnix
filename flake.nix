{
  description = "Me system(s) flake :)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ngrams.url = "github:mfroeh/ngrams";
    ngrams.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun-swaywin = {
      url = "github:mfroeh/anyrun-swaywin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixd-completion-in-attr-sets-fix = {
      url = "github:oandrew/nixd/completion-fixes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # weekly updated nix-index database for nixpkgs/nixos-unstable channel
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      rust-overlay,
      nur,
      nix-index-database,
      ...
    }@inputs:
    let
      pkgsOverlay = final: prev: {
        swtchr = prev.callPackage ./pkgs/swtchr { };
      };

      # overlay that fixes dolphin ignoring mimeTypes when used without KDE
      standaloneDolphinOverlay = final: prev: {
        kdePackages = prev.kdePackages.overrideScope (
          kfinal: kprev: {
            dolphin = kprev.dolphin.overrideAttrs (oldAttrs: {
              nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ prev.makeWrapper ];
              postInstall = (oldAttrs.postInstall or "") + ''
                wrapProgram $out/bin/dolphin \
                    --set XDG_CONFIG_DIRS "${prev.libsForQt5.kservice}/etc/xdg:$XDG_CONFIG_DIRS" \
                    --run "${kprev.kservice}/bin/kbuildsycoca6 --noincremental ${prev.libsForQt5.kservice}/etc/xdg/menus/applications.menu"
              '';
            });
          }
        );
      };

      mkPkgs =
        { system, nixpkgs }:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.allowUnfreePredicate = _: true;
          # https://github.com/LnL7/nix-darwin/issues/1041
          overlays = [
            nur.overlays.default
            # override this inside devshell where necessary
            rust-overlay.overlays.default
            (self: super: {
              karabiner-elements = super.karabiner-elements.overrideAttrs (old: {
                version = "14.13.0";

                src = super.fetchurl {
                  inherit (old.src) url;
                  hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
                };
              });
            })
            pkgsOverlay
            standaloneDolphinOverlay
          ];
        };

      mkSpecialArgs =
        args@{ system, ... }:
        {
          inherit self inputs system;
        }
        // args;
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
        nulty = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = mkPkgs { inherit system nixpkgs; };
          modules = [
            ./modules/nix.nix
            "${self}/hosts/nulty"
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
              nix-index-database.homeModules.default
              "${self}/users/mo/home.nix"
            ];
            extraSpecialArgs = mkSpecialArgs {
              inherit system;
              home-config-name = "mo@lambda";
              system-config-name = "lambda";
            };
          };
        "mo@nulty" =
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
              nix-index-database.homeModules.default
              "${self}/users/mo/home.nix"
            ];
            extraSpecialArgs = mkSpecialArgs {
              inherit system;
              home-config-name = "mo@nulty";
              system-config-name = "nulty";
            };
          };
        "mo@xya" =
          let
            system = "aarch64-darwin";
          in
          home-manager.lib.homeManagerConfiguration {
            pkgs = mkPkgs { inherit nixpkgs system; };
            modules = [
              {
                home.stateVersion = "25.11";
                programs.home-manager.enable = true;
                home = {
                  username = "mo";
                  homeDirectory = "/Users/mo";
                };
              }
              nix-index-database.homeModules.default
              "${self}/users/mo/home.nix"
            ];
            extraSpecialArgs = mkSpecialArgs {
              inherit system;
              home-config-name = "mo@xya";
              # TODO: make nixd work with nix-darwin
              system-config-name = "xya";
            };
          };
        "moritz.froehlich@lenovo-PW09JP9W" =
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
                  username = "moritz.froehlich";
                  homeDirectory = "/home/moritz.froehlich";
                };
              }
              nix-index-database.homeModules.default
              "${self}/users/work/home.nix"
            ];
            extraSpecialArgs = mkSpecialArgs {
              inherit system;
              home-config-name = "moritz.froehlich@lenovo-PW09JP9W";
              system-config-name = "none";
            };
          };
      };
    };
}
