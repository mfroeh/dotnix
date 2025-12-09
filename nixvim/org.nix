{ pkgs, ... }:
{
  programs.nixvim.plugins.neorg = {
    enable = true;
    settings = {
      load = {
        "core.concealer" = {
          config = {
            icon_preset = "varied";
          };
        };
        "core.defaults" = {
          __empty = null;
        };
        "core.dirman" = {
          config = {
            workspaces = {
              default = "~/neorg-notes/";
            };
          };
        };
      };
    };
  };
}
