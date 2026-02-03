{
  flake.modules.homeManager.man =
    { pkgs, ... }:
    {
      programs.man.enable = true;

      home.packages = [
        pkgs.bat-extras.batman
        pkgs.man-pages
      ];
      programs.zsh.shellAliases = {
        "man" = "batman";
      };

      # tldr
      programs.tealdeer = {
        enable = true;
        settings = {
          updates = {
            auto_update = true;
          };
        };
      };
    };
}
