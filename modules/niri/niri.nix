{ inputs, ... }:
{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      imports = [ inputs.niri.nixosModules.niri ];
      home-manager.sharedModules = [ inputs.self.modules.homeManager.niri ];

      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      services.displayManager = {
        enable = true;
        gdm = {
          enable = true;
          wayland = true;
        };
      };

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };

      environment.systemPackages = with pkgs; [ xwayland-satellite ];

      # https://nixos.wiki/wiki/Wayland
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };

  flake.modules.homeManager.niri =
    { pkgs, config, ... }:
    {
      programs.niri.settings = null;
      programs.niri.config = null;

      xdg.configFile."niri/config.kdl".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/niri/config.kdl";

      services.mako = {
        enable = true;
        settings = { };
      };

      services.swayidle = {
        enable = true;
        timeouts = [
          {
            timeout = 601;
            command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
          }
          {
            timeout = 600;
            command = "${pkgs.swaylock}/bin/swaylock -f' before-sleep 'swaylock -f";
          }
        ];
        events.before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
      };

      programs.waybar = {
        enable = true;
      };

      home.packages = [ ];

      programs.alacritty.enable = true;

      programs.anyrun = {
        enable = true;
        config = {
          x = {
            fraction = 0.5;
          };
          y = {
            fraction = 0.3;
          };
          width = {
            fraction = 0.3;
          };
          hideIcons = false;
          ignoreExclusiveZones = false;
          layer = "overlay";
          hidePluginInfo = false;
          closeOnClick = false;
          showResultsImmediately = true;
          maxEntries = null;
          plugins = [
            "${pkgs.anyrun}/lib/libapplications.so"
            "${pkgs.anyrun}/lib/libsymbols.so"
          ];
        };
      };
    };
}
