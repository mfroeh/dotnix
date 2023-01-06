{
  config, 
    pkgs, 
    lib,
    self,
    ...
}: {
  gtk = {
    enable = true;
    # theme.package = pkgs.zuki-themes;
    theme.name = "Adwaita-dark";

    gtk3.bookmarks = [
      "file://${config.home.homeDirectory}/dotnix"
      "file://${config.home.homeDirectory}/dev"
    ];
  };
}
