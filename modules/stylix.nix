{ inputs, ... }:
{
  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      imports = [ inputs.stylix.nixosModules.default ];
      home-manager.sharedModules = [
        inputs.self.modules.homeManager.stylix
      ];

      stylix.enable = true;
      stylix.autoEnable = true;
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
      stylix.fonts = {
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
      stylix.cursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-light";
        size = 24;
      };

      stylix.icons = {
        enable = true;
        package = pkgs.numix-icon-theme-circle;
        dark = "Numix-Circle";
      };
      stylix.polarity = "dark";
    };

  flake.modules.homeManager.stylix = {
    imports = [ ];
    stylix.enable = true;
    stylix.targets.firefox = {
      profileNames = [ "default" ];
      firefoxGnomeTheme.enable = true;
    };
  };
}
