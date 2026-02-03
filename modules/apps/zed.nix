{
  flake.modules.homeManager.zed =
    { config, ... }:
    {
      programs.zed-editor = {
        enable = true;
      };

      xdg.configFile."zed/settings.json".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/zed/settings.json";
      xdg.configFile."zed/keymap.json".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/zed/keymap.json";
      xdg.configFile."zed/snippets".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/zed/snippets";
    };
}
