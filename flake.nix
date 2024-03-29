{
  description = "Me systems flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-apple-silicon.url = "github:tpwrules/nixos-apple-silicon/main";
    nixos-apple-silicon.inputs.nixpkgs.follows = "nixpkgs";
    nixos-apple-silicon.inputs.rust-overlay.follows = "rust-overlay";

    nixos-wsl.url = "github:nix-community/nixos-wsl";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    xremap-flake.url = "github:xremap/nix-flake";
    xremap-flake.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mtree = {
      url = "github:mfroeh/tree";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , nixos-stable
    , nixpkgs-unstable
    , darwin
    , nixos-apple-silicon
    , nixos-wsl
    , nixos-hardware
    , home-manager
    , xremap-flake
    , neovim-nightly-overlay
    , hyprland
    , rust-overlay
    , mtree
    , ...
    }:
    let
      isDarwin = system:
        (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);
      homePrefix = system: if isDarwin system then "/Users" else "/home";

      mkPkgs = { system, nixpkgs }:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            rust-overlay.overlays.default
            nixos-apple-silicon.overlays.default
            neovim-nightly-overlay.overlay
          ];
        };

      # Available for nixos, darwin and home-manager configuration
      mkSpecialArgs = { self, system, username, inputs, ... }: {
        inherit self system username inputs;
        platform = {
          aarch64-linux = system == "aarch64-linux";
          aarch64-darwin = system == "aarch64-darwin";
          x86_64-linux = system == "x86_64-linux";
          x86_64-darwin = system == "x86_64-darwin";
        };
        pkgsUnstable = mkPkgs {
          inherit system;
          nixpkgs = nixpkgs-unstable;
        };
        pkgsStable = mkPkgs {
          inherit system;
          nixpkgs = nixos-stable;
        };
      };

      mkNixosConfig = { system, host, username, extraModules ? [ ], }:
        nixpkgs.lib.nixosSystem rec {
          inherit system;
          pkgs = mkPkgs { inherit system nixpkgs; };
          modules =
            [ ./modules/nixos-base.nix ./users/${username}.nix ./hosts/${host} ]
            ++ extraModules;
          specialArgs = mkSpecialArgs { inherit self system username inputs; };
        };

      mkDarwinConfig = { system, host, username, extraModules ? [ ], }:
        darwin.lib.darwinSystem rec {
          inherit system;
          pkgs = mkPkgs { inherit system nixpkgs; };
          modules = [
            ./modules/darwin-base.nix
            ./hosts/${host}
            ./users/${username}.nix
          ] ++ extraModules;
          specialArgs = mkSpecialArgs { inherit self system username inputs; };
        };

      mkHomeConfig =
        { username, system, extraModules ? [ ], extraPkgs ? pkgs: [ ], }:
        home-manager.lib.homeManagerConfiguration rec {
          pkgs = mkPkgs { inherit system nixpkgs; };
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
          extraSpecialArgs =
            mkSpecialArgs { inherit self system username inputs; };
        };
    in
    {
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
        pi = mkNixosConfig {
          system = "aarch64-linux";
          host = "pi";
          username = "mo";
        };
        wsl = mkNixosConfig {
          system = "x86_64-linux";
          host = "wsl";
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
            {
              languages = {
                lua = true;
                cpp = true;
                latex = true;
                haskell = true;
                python = true;
                rust = true;
              };
            }

            ./modules/home-manager/nixos/gtk.nix
            ./modules/home-manager/nixos/gnome.nix
            ./modules/home-manager/nixos/rofi.nix

            ./modules/home-manager/nixos/chromium.nix

            # Until https://github.com/kovidgoyal/kitty/pull/5795 merged
            ./modules/home-manager/common/alacritty.nix
            ./modules/home-manager/common/helix.nix

            ./modules/home-manager/nixos/rclone.nix
            ./modules/home-manager/nixos/vlc.nix
          ];
          extraPkgs = pkgs: with pkgs; [ ];
        };
        "mo@lambda" = mkHomeConfig {
          username = "mo";
          system = "x86_64-linux";
          extraModules = [
            {
              languages = {
                lua = true;
                cpp = true;
                latex = true;
                python = true;
                rust = true;
              };
            }

            ./modules/home-manager/nixos/gtk.nix
            ./modules/home-manager/nixos/gnome.nix
            ./modules/home-manager/nixos/rofi.nix

            ./modules/home-manager/common/helix.nix
            ./modules/home-manager/common/tmux.nix
            ./modules/home-manager/common/jetbrains.nix

            ./modules/home-manager/nixos/rclone.nix
            ./modules/home-manager/nixos/vlc.nix
          ];
          extraPkgs = pkgs: with pkgs; [ ];
        };
        "mo@pi" = mkHomeConfig {
          username = "mo";
          system = "aarch64-linux";
          extraModules = [ ];
        };
        "mo@wsl" = mkHomeConfig {
          username = "mo";
          system = "x86_64-linux";
          extraModules = [ ];
        };
      };
    };
}
