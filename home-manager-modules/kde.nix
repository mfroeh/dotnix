{ self, pkgs, inputs, system, ... }:
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

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # high-level settings
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Cluster/contents/images/3840x2160.png";
    };

    panels = [
      (createBottomPanel 0)
    ];

    # mid-level settings:
    shortcuts = {
      "services/org.kde.krunner.desktop"."_launch" = "Alt+I";
      "services/org.kde.dolphin.desktop"."_launch" = "Alt+E";
      "services/kitty.desktop"."_launch" = "Alt+Y";

      kwin = {
        "Window Maximize" = "Alt+F";
        "Window Close" = "Alt+C";
        "Grid View" = "Alt+W";
        "ExposeAll" = "Alt+,";
        "Switch Window Down" = "Alt+J";
        "Switch Window Left" = "Alt+H";
        "Switch Window Right" = "Alt+L";
        "Switch Window Up" = "Alt+K";
        "Window Quick Tile Bottom" = "Alt+Shift+J";
        "Window Quick Tile Left" = "Alt+Shift+H";
        "Window Quick Tile Right" = "Alt+Shift+L";
        "Window Quick Tile Top" = "Alt+Shift+K";
      };

      kwin = {
        "Switch to Desktop 1" = "Alt+1";
        "Switch to Desktop 2" = "Alt+2";
        "Switch to Desktop 3" = "Alt+3";
        "Switch to Desktop 4" = "Alt+4";
        "Switch to Desktop 5" = "Alt+5";
        "Switch to Desktop 6" = "Alt+6";
        "Switch to Desktop 7" = "Alt+7";
        "Switch to Desktop 8" = "Alt+8";
        "Switch to Desktop 9" = "Alt+9";
        "Switch to Desktop 10" = "Alt+0";
        "Window to Desktop 1" = "Alt+!";
        "Window to Desktop 2" = "Alt+@";
        "Window to Desktop 3" = "Alt+#";
        "Window to Desktop 4" = "Alt+$";
        "Window to Desktop 5" = "Alt+%";
        "Window to Desktop 6" = "Alt+^";
        "Window to Desktop 7" = "Alt+&";
        "Window to Desktop 8" = "Alt+*";
        "Window to Desktop 9" = "Alt+(";
        "Window to Desktop 10" = "Alt+)";
      };
    };

    # low-level settings:
    configFile = {
      "krunnerrc"."General"."FreeFloating" = true;

      kwinrc."Effect-overview".BorderActivate = 9;


      kxkbrc.Layout = {
        DisplayNames = "us,ru";
        LayoutList = "us,us";
        VariantList = ",rus";
        Options = "grp:alt_space_toggle";
        ResetOldOptions = true;
        Use = true;
        SwitchMode = "Global";
      };

      kwinrc.Desktops.Number = {
        value = 10;
        immutable = true;
      };
    };
  };
}
