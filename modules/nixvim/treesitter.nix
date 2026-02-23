{
  flake.nixvim.treesitter =
    { pkgs, ... }:
    {
      plugins.treesitter = {
        enable = true;
        grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # disable all built in per filetype mappings to avoid clashes with treesitter-textobjects defined mappings
      globals.no_plugin_maps = true;
      plugins.treesitter-textobjects = {
        enable = true;
        settings = {
          select = {
            lookahead = true;
            include_surrounding_whitespace = false;
          };
          move = {
            set_jumps = true;
          };
        };
      };

      plugins.treesitter-context = {
        enable = true;
        settings = {
          max_lines = 2;
        };
      };

      extraFiles = {
        "queries/nix/textobjects.scm".source = ./queries/nix/textobjects.scm;
        "queries/go/textobjects.scm".source = ./queries/go/textobjects.scm;
      };

      # adds indentation textobjects `ii` and `ai` as well as move with `[i` and `]i`
      plugins.indent-tools.enable = false;

      keymaps =
        let
          treesitter-select-mapping = key: capture: {
            inherit key;
            mode = [
              "x"
              "o"
            ];
            action = ":lua require('nvim-treesitter-textobjects.select').select_textobject('${capture}', 'textobjects')<cr>";
            options.silent = true;
          };
          treesitter-jump-mapping-next-start = key: capture: {
            inherit key;
            mode = [
              "n"
              "x"
              "o"
            ];
            action = ":lua require('nvim-treesitter-textobjects.move').goto_next_start('${capture}', 'textobjects')<cr>";
            options.silent = true;
          };
          treesitter-jump-mapping-prev-start = key: capture: {
            inherit key;
            mode = [
              "n"
              "x"
              "o"
            ];
            action = ":lua require('nvim-treesitter-textobjects.move').goto_previous_start('${capture}', 'textobjects')<cr>";
            options.silent = true;
          };
        in
        [
          {
            key = "[x";
            mode = "n";
            action = ":lua require('treesitter-context').go_to_context(vim.v.count1)<cr>";
            options.silent = true;
          }
          # select
          (treesitter-select-mapping "aa" "@parameter.outer")
          (treesitter-select-mapping "ia" "@parameter.inner")
          (treesitter-select-mapping "af" "@function.outer")
          (treesitter-select-mapping "if" "@function.outer")
          (treesitter-select-mapping "aC" "@class.outer")
          (treesitter-select-mapping "iC" "@class.inner")
          # only defined by me so not complete for all languages
          (treesitter-select-mapping "ae" "@element.inner")
          (treesitter-select-mapping "ie" "@element.outer")
          # jump
          # todo: figure out sensible mapping for [[ and ]] (maybe scopes?)
          (treesitter-jump-mapping-prev-start "[a" "@parameter.outer")
          (treesitter-jump-mapping-next-start "]a" "@parameter.outer")

          (treesitter-jump-mapping-prev-start "[f" "@function.outer")
          (treesitter-jump-mapping-next-start "]f" "@function.outer")

          (treesitter-jump-mapping-prev-start "[C" "@class.outer")
          (treesitter-jump-mapping-next-start "]C" "@class.outer")
          {
            key = ";";
            mode = [
              "n"
              "x"
              "o"
            ];
            action = ":lua require('nvim-treesitter-textobjects.repeatable_move').repeat_last_move()<cr>";
            options.silent = true;
          }
          {
            key = ",";
            mode = [
              "n"
              "x"
              "o"
            ];
            action = ":lua require('nvim-treesitter-textobjects.repeatable_move').repeat_last_move_opposite()<cr>";
            options.silent = true;
          }
          {
            key = "f";
            mode = [
              "n"
              "x"
              "o"
            ];
            action = ":lua require('nvim-treesitter-textobjects.repeatable_move').builtin_f_expr()<cr>";
            options.silent = true;
            options.expr = true;
          }
          {
            key = "F";
            mode = [
              "n"
              "x"
              "o"
            ];
            action = ":lua require('nvim-treesitter-textobjects.repeatable_move').builtin_F_expr()<cr>";
            options.silent = true;
            options.expr = true;
          }
          {
            key = "t";
            mode = [
              "n"
              "x"
              "o"
            ];
            action = ":lua require('nvim-treesitter-textobjects.repeatable_move').builtin_t_expr()<cr>";
            options.silent = true;
            options.expr = true;
          }
          {
            key = "T";
            mode = [
              "n"
              "x"
              "o"
            ];
            action = ":lua require('nvim-treesitter-textobjects.repeatable_move').builtin_T_expr()<cr>";
            options.silent = true;
            options.expr = true;
          }
        ];
    };
}
