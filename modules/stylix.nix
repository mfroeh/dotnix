{ inputs, lib, ... }:
{
  flake.modules.nixos.stylix = {
    imports = [ inputs.stylix.nixosModules.default ];
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.stylix
    ];
  };

  flake.modules.darwin.stylix = {
    imports = [ inputs.stylix.darwinModules.default ];
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.stylix
    ];
  };

  flake.modules.homeManager.stylix =
    { pkgs, ... }:
    {
      imports = [ inputs.stylix.homeModules.default ];
      stylix = lib.mkMerge [
        {
          enable = true;
          autoEnable = true;
          base16Scheme = "${pkgs.base16-schemes}/share/themes/oceanicnext.yaml";

          fonts = {
            monospace = {
              package = pkgs.nerd-fonts.jetbrains-mono;
              name = "JetBrainsMono Nerd Font";
            };
            sansSerif = {
              package = pkgs.dejavu_fonts;
              name = "DejaVu Sans";
            };
            serif = {
              package = pkgs.dejavu_fonts;
              name = "DejaVu Serif";
            };
            emoji = {
              package = pkgs.noto-fonts-color-emoji;
              name = "Noto Color Emoji";
            };

            sizes = {
              applications = 10;
              desktop = 10;
              popups = 10;
              terminal = 10;
            };
          };
          polarity = "dark";

          targets.firefox = {
            profileNames = [ "default" ];
            firefoxGnomeTheme.enable = true;
          };
        }
        (lib.mkIf pkgs.stdenv.isLinux {
          cursor = {
            package = pkgs.phinger-cursors;
            name = "phinger-cursors-light";
            size = 24;
          };
          icons = {
            enable = true;
            package = pkgs.numix-icon-theme-circle;
            dark = "Numix-Circle";
          };
        })
      ];
    };
}
