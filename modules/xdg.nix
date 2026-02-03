{
  flake.modules.homeManager.xdg =
    { config, ... }:
    {
      xdg = {
        enable = true;
        stateHome = "${config.home.homeDirectory}/.local/state";
        dataHome = "${config.home.homeDirectory}/.local/share";
        configHome = "${config.home.homeDirectory}/.config";
        cacheHome = "${config.home.homeDirectory}/.cache";

        # sets XDG_DESKTOP_DIR, ...
        userDirs = {
          enable = true;
          desktop = "${config.home.homeDirectory}/Desktop";
          documents = "${config.home.homeDirectory}/Documents";
          download = "${config.home.homeDirectory}/Downloads";
          music = "${config.home.homeDirectory}/Music";
          pictures = "${config.home.homeDirectory}/Pictures";
          publicShare = "${config.home.homeDirectory}/Public";
          templates = "${config.home.homeDirectory}/Templates";
          videos = "${config.home.homeDirectory}/Videos";
        };
      };
    };
}
