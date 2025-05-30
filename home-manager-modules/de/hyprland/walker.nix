{ pkgs, lib, inputs, ... }:
{
  imports = [ inputs.walker.homeManagerModules.default ];
  programs.walker = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    runAsService = true;

    # All options from the config.json can be used here.
    config = {
      ui.fullscreen = true;
      list = {
        height = 200;
      };
      websearch.prefix = "?";
      switcher.prefix = "/";
    };
  };
}
