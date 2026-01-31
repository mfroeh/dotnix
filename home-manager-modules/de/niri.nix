{
  self,
  pkgs,
  config,
  ...
}:
{
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

  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/home-manager-modules/de/config.kdl";

  # https://nixos.wiki/wiki/Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
