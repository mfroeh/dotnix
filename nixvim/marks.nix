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
            rev = "global-marks";
            hash = "sha256-/kpODNZQFEpF/Klvaz3aSDQ0wKQmfJj7nMaLu6MIKKw=";
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
          "." # position of the last change (e.g. insert, change, delete)
          "^" # position where we last exited insert mode, use gi to jump there and begin inserting
          "'"
          "\""
          "["
          "]"
          "<"
          ">"
        ];
      };
    };

    autoCmd = [
      {
        desc = "set I mark when existing insert mode";
        event = [ "InsertLeave" ];
        pattern = [ "*" ];
        callback.__raw = ''
          function()
            local pos = vim.api.nvim_win_get_cursor(0)
            vim.api.nvim_buf_set_mark(0, "I", pos[1], pos[2], {})
          end
        '';
      }
    ];

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
      {
        key = "gI";
        mode = "n";
        action = "`Ii";
      }
    ];
  };
}
