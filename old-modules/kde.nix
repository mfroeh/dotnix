{
  self,
  pkgs,
  inputs,
  system,
  ...
}:
let
  createBottomPanel = screen: {
    height = 28;
    inherit screen;
    hiding = "normalpanel";
    location = "bottom";
    floating = false;
    widgets = [
      {
        name = "org.kde.plasma.kickerdash";
        config.General.icon = "nix-snowflake-white";
      }
      {
        name = "org.kde.plasma.pager";
        config.General = {
          displayedText = "Number";
          showWindowIcons = "true";
        };
      }
      "org.kde.plasma.panelspacer"
      {
        name = "org.kde.plasma.icontasks";
        config.General =
          # https://github.com/KDE/plasma-desktop/blob/master/applets/taskmanager/package/contents/config/main.xml
          {
            showOnlyCurrentDesktop = "false";
            showOnlyCurrentActivity = "false";
            showOnlyCurrentScreen = "true";
            launchers = [ ];
            sortingStrategy = "3";
            groupingStrategy = "0";
          };
      }
      "org.kde.plasma.panelspacer"
      {
        name = "org.kde.plasma.weather";
      }
      {
        systemTray = {
          items = {
            shown = [
              "org.kde.plasma.battery"
              "org.kde.plasma.clipboard"
              "org.kde.plasma.networkmanagement"
              "org.kde.plasma.volume"
            ];
          };
        };
      }
      {
        digitalClock = {
          calendar = {
            plugins = [ "holidaysevents" ];
          };
          date.position = "besideTime";
        };
      }
    ];
  };

in
{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  home.packages = with pkgs; [ layan-kde ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # high-level settings
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      wallpaper = "${self}/config/wallpapers/mirroring.png";
    };

    panels = [
      (createBottomPanel 0)
    ];

    # mid-level settings:
    shortcuts = {
      "services/org.kde.krunner.desktop"."_launch" = "Meta+Space";
      "services/org.kde.dolphin.desktop"."_launch" = "Meta+E";

      kwin = {
        "Window Maximize" = "Meta+F";
        "Window Close" = "Meta+C";
        "Grid View" = "Meta+W";
        "ExposeAll" = "Meta+,";
        "Switch Window Down" = "Meta+J";
        "Switch Window Left" = "Meta+H";
        "Switch Window Right" = "Meta+L";
        "Switch Window Up" = "Meta+K";
        "Window Quick Tile Bottom" = "Meta+Shift+J";
        "Window Quick Tile Left" = "Meta+Shift+H";
        "Window Quick Tile Right" = "Meta+Shift+L";
        "Window Quick Tile Top" = "Meta+Shift+K";
      };

      kwin = {
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
        "Switch to Desktop 10" = "Meta+0";
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+@";
        "Window to Desktop 3" = "Meta+#";
        "Window to Desktop 4" = "Meta+$";
        "Window to Desktop 5" = "Meta+%";
        "Window to Desktop 6" = "Meta+^";
        "Window to Desktop 7" = "Meta+&";
        "Window to Desktop 8" = "Meta+*";
        "Window to Desktop 9" = "Meta+(";
        "Window to Desktop 10" = "Meta+)";
      };
    };

    # low-level settings:
    configFile = {
      "krunnerrc"."General"."FreeFloating" = true;

      kwinrc."Effect-overview".BorderActivate = 9;

      # kxkbrc.Layout = {
      #   DisplayNames = "us,ru";
      #   LayoutList = "us,us";
      #   VariantList = ",rus";
      #   Options = "grp:alt_space_toggle";
      #   ResetOldOptions = true;
      #   Use = true;
      #   SwitchMode = "Global";
      # };

      kwinrc.Desktops.Number = {
        value = 10;
        immutable = true;
      };
    };
  };
}
