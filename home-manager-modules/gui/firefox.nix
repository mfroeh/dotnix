{ config, pkgs, ... }:
{
  # firefox can use the installed hunspellDicts from $DICPATH
  home.packages = with pkgs; [
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE
    # allow firefox to properly display notifications
    libnotify
  ];
  home.sessionVariables = {
    DICPATH = "${config.home.homeDirectory}/.nix-profile/share/hunspell";
  };

  home.file.".tridactylrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/.tridactylrc";

  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      nativeMessagingHosts = with pkgs; [
        tridactyl-native
      ];
    };
    languagePacks = [
      "en-US"
      "de"
    ];
    profiles.default = {
      # will have to restart firefox once for these to apply
      extraConfig = ''
              // sidebar
              user_pref("sidebar.revamp", true);
              user_pref("sidebar.verticalTabs", true);
              user_pref("sidebar.visibility", "always-show");
        			// dark mode
        			user_pref("browser.theme.content-theme", 2);
              // newtabpage
              user_pref("browser.newtabpage.activity-stream.newtabWallpapers.wallpaper", "abstract-orange");
              user_pref("browser.newtabpage.activity-stream.feeds.topsites", true);
              user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);
              user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
              user_pref("browser.newtabpage.activity-stream.system.showSponsoredCheckboxes", false);
      '';
    };
  };
}
