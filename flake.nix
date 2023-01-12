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

  outputs =
    inputs@{ self, nixpkgs, stable, darwin, home-manager, xremap-flake, ... }:
    let
      isDarwin = system:
        (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);
      homePrefix = system: if isDarwin system then "/Users" else "/home";

      mkPkgs = system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      mkNixosConfig = { system, host, username, extraModules ? [ ], }:
        nixpkgs.lib.nixosSystem rec {
          inherit system;
          pkgs = mkPkgs system;
          modules =
            [ ./modules/nixos-base.nix ./users/${username}.nix ./hosts/${host} ]
            ++ [ xremap-flake.nixosModules.default ] # Flake modules
            ++ extraModules;
          specialArgs = { inherit self system username inputs; };
        };

      mkDarwinConfig = { system, host, username, extraModules ? [ ], }:
        darwin.lib.darwinSystem rec {
          inherit system;
          pkgs = mkPkgs system;
          modules = [
            ./modules/darwin-base.nix
            ./hosts/${host}
            ./users/${username}.nix
          ] ++ extraModules;
          specialArgs = { inherit self system username inputs; };
        };

      mkHomeConfig =
        { username, system, extraModules ? [ ], extraPkgs ? pkgs: [ ], }:
        home-manager.lib.homeManagerConfiguration rec {
          pkgs = mkPkgs system;
          modules = [
            ./modules/home-manager/${
              if isDarwin system then "darwin" else "nixos"
            }-base.nix
            {
              home = {
                inherit username;
                homeDirectory = "${homePrefix system}/${username}";
                packages = extraPkgs pkgs;
              };
            }
          ] ++ extraModules;
          extraSpecialArgs = { inherit self system username inputs; };
        };
    in {
      darwinConfigurations = {
        gus = mkDarwinConfig {
          system = "aarch64-darwin";
          host = "gus";
          username = "mo";
        };
      };

      nixosConfigurations = {
        herc = mkNixosConfig {
          system = "x86_64-linux";
          host = "herc";
          username = "mo";
        };
        eta = mkNixosConfig {
          system = "aarch64-linux";
          host = "eta";
          username = "mo";
        };
        lambda = mkNixosConfig {
          system = "x86_64-linux";
          host = "lambda";
          username = "mo";
        };
      };

      homeConfigurations = {
        "mo@gus" = mkHomeConfig {
          username = "mo";
          system = "aarch64-darwin";
          extraModules = [ ./modules/home-manager/darwin/karabiner.nix ];
        };
        "mo@herc" = mkHomeConfig {
          username = "mo";
          system = "x86_64-linux";
          extraModules = [ ];
        };
        "mo@eta" = mkHomeConfig {
          username = "mo";
          system = "aarch64-linux";
          extraModules = [
            ./modules/home-manager/languages/nix.nix
            ./modules/home-manager/languages/cpp.nix
            ./modules/home-manager/languages/python.nix

            ./modules/home-manager/nixos/gtk.nix
            ./modules/home-manager/nixos/gnome.nix
            ./modules/home-manager/nixos/rofi.nix

            # Until https://github.com/kovidgoyal/kitty/pull/5795 merged
            ./modules/home-manager/common/alacritty.nix
            ./modules/home-manager/common/helix.nix
          ];
          extraPkgs = pkgs: with pkgs; [ ];
        };
        "mo@lambda" = mkHomeConfig {
          username = "mo";
          system = "x86_64-linux";
          extraModules = [
            ./modules/home-manager/languages/nix.nix
            ./modules/home-manager/languages/cpp.nix
            ./modules/home-manager/languages/python.nix

            ./modules/home-manager/nixos/gtk.nix
            ./modules/home-manager/nixos/gnome.nix
            ./modules/home-manager/nixos/rofi.nix

            ./modules/home-manager/common/helix.nix
          ];
          extraPkgs = pkgs: with pkgs; [ ];
        };
      };
    };
}
