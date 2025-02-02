{ self, config, ... }:
{
  home.file."${config.xdg.configHome}/wallpapers" = {
    source = "${self}/config/wallpapers";
    recursive = true;
  };
}
