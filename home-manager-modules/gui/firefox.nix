{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
      "de"
    ];
    profiles.default = {
      settings = {
        "extensions.autoDisableScopes" = 0;
      };

      extraConfig = ''
        																																// sidebar
                                                                        user_pref("sidebar.revamp", true);
                                                                        user_pref("sidebar.verticalTabs", true);
                                                                        user_pref("sidebar.visibility", "expand-on-hover");
                                																				// dark mode
                                																				user_pref("browser.theme.content-theme", 2);
                        																								// theme
                                                        								user_pref("extensions.activeThemeID", "firefox-alpenglow@mozilla.org");
                                                                        			'';

      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          vimium-c
          bitwarden
          sponsorblock
          dearrow
          return-youtube-dislikes
        ];
      };

      search = {
        force = true;
        default = "google";
        engines = {
          "Nix Packages" = {
            url = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              }
            ];
          };
          "Home Manager options" = {
            url = [
              {
                template = "https://home-manager-options.extranix.com";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@ho" ];
              }
            ];
          };
        };
      };
    };
  };
}
