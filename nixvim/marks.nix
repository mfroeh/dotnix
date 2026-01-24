{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.mark-radar = {
      enable = true;
      package = (
        pkgs.vimUtils.buildVimPlugin {
          name = "mark-radar";
          src = pkgs.fetchFromGitHub {
            owner = "mfroeh";
            repo = "mark-radar.nvim";
            rev = "master";
            hash = "sha256-mEZi4TB1BJqWEAjH/VYClfuUcDb57yPQdhR9b5PJez4=";
          };
        }
      );
      settings = {
        set_default_mappings = false;
        show_off_screen_marks = true;
        show_marks_at_jump_positions = true;
      };
    };

    # https://github.com/chentoast/marks.nvim/
    plugins.marks = {
      enable = true;
      settings = {
        default_mappings = true;
        builtin_marks = [
          "."
          "^"
          "'"
          "\""
          "["
          "]"
          "<"
          ">"
        ];
      };
    };

    keymaps = [
      # map ' to ` since the default behavior of ` is more useful
      {
        key = "'";
        mode = "n";
        action.__raw = ''
          function()
            pcall(function() require('treesitter-context').disable() end)
            require('mark-radar').scan(true)
            pcall(function() require('treesitter-context').enable() end)
          end
        '';
        options.silent = true;
      }
      {
        key = "`";
        mode = "n";
        action.__raw = ''
          function()
            pcall(function() require('treesitter-context').disable() end)
            require('mark-radar').scan(false)
            pcall(function() require('treesitter-context').enable() end)
          end
        '';
        options.silent = true;
      }
      # todo set a global mark whenever a . mark is set, super useful for doing a bunch of gd and then getting back to work
    ];
  };
}
