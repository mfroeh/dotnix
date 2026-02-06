{ inputs, ... }:
{
  flake.modules.nixos.remaps =
    { config, lib, ... }:
    {
      # https://github.com/xremap/nix-flake/blob/master/docs/HOWTO.md
      imports = [ inputs.xremap-flake.nixosModules.default ];

      options.services.remap = {
        capsToCtrl = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };

        ctrlLeftbraceToEsc = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };

        swpBackslashBackspace = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
      };

      config.services.xremap = {
        enable = true;
        serviceMode = "system";
        watch = true;
        config = {
          modmap =
            lib.optionals config.services.remap.capsToCtrl [
              {
                name = "CapsLock -> Ctrl_L";
                remap = {
                  CapsLock = "Ctrl_L";
                };
              }
            ]
            ++ lib.optionals config.services.remap.swpBackslashBackspace [
              {
                name = "Backslash <-> Backspace";
                remap = {
                  Backslash = "Backspace";
                  Backspace = "Backslash";
                };
              }
            ];
          keymap = lib.optionals config.services.remap.ctrlLeftbraceToEsc [
            {
              name = "C-[ -> Esc";
              remap = {
                "C-Leftbrace" = "Esc";
              };
            }
          ];
        };
      };
    };

  flake.modules.darwin.remaps =
    { pkgs, ... }:
    {
      services.karabiner-elements = {
        enable = true;
        package = pkgs.karabiner-elements.overrideAttrs (old: {
          version = "14.13.0";

          src = pkgs.fetchurl {
            inherit (old.src) url;
            hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
          };

          dontFixup = true;
        });
      };
      home-manager.sharedModules = [
        (
          { config, ... }:
          {
            home.file.".config/karabiner/karabiner.json".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/karabiner/config.json";
          }
        )
      ];
    };
}
