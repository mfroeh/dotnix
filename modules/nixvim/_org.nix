{ pkgs, ... }:
{
  plugins.neorg = {
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
            workspaces = rec {
              cloud = if pkgs.stdenv.isDarwin then "~/Google Drive/My Drive" else "~/Google Drive";
              notes = "${cloud}/Notes/";
            };
            default_workspace = "notes";
          };
        };
        "core.journal" = {
          config = {
            journal_folder = "Journal";
            template_name = "template.norg";
            use_template = true;
            strategy = "flat";
            workspace = "cloud";
          };
        };
        "core.export" = {
          __empty = null;
        };
      };
    };
  };
}
