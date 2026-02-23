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
            action.__raw = "function() require('nvim-treesitter-textobjects.select').select_textobject('${capture}', 'textobjects') end";
            options.silent = true;
          };
          treesitter-jump-mapping-next-start = key: capture: {
            inherit key;
            mode = [
              "n"
              "x"
              "o"
            ];
            action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_start('${capture}', 'textobjects') end";
            options.silent = true;
          };
          treesitter-jump-mapping-prev-start = key: capture: {
            inherit key;
            mode = [
              "n"
              "x"
              "o"
            ];
            action.__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_start('${capture}', 'textobjects') end";
            options.silent = true;
          };
        in
        [
          {
            key = "[x";
            mode = "n";
            action.__raw = "function() require('treesitter-context').go_to_context(vim.v.count1) end";
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
            action.__raw = "function() require('nvim-treesitter-textobjects.repeatable_move').repeat_last_move() end";
            options.silent = true;
          }
          {
            key = ",";
            mode = [
              "n"
              "x"
              "o"
            ];
            action.__raw = "function() require('nvim-treesitter-textobjects.repeatable_move').repeat_last_move_opposite() end";
            options.silent = true;
          }
          {
            key = "f";
            mode = [
              "n"
              "x"
              "o"
            ];
            action.__raw = "require('nvim-treesitter-textobjects.repeatable_move').builtin_f_expr";
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
            action.__raw = "require('nvim-treesitter-textobjects.repeatable_move').builtin_F_expr";
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
            action.__raw = "require('nvim-treesitter-textobjects.repeatable_move').builtin_t_expr";
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
            action.__raw = "require('nvim-treesitter-textobjects.repeatable_move').builtin_T_expr";
            options.silent = true;
            options.expr = true;
          }
        ];

      # Enhances % to work with tree-sitter (quotes, if/else, etc.)
      plugins.vim-matchup = {
        enable = true;
        treesitter.enable = true;
        settings = {
          matchparen_deferred = 1;
          # Disable offscreen match display for performance
          matchparen_offscreen = {
            __empty = null;
          };
        };
      };

      # does not work after non backwards compatible changes to treesitter.
      # check again once compatible again.
      # see https://github.com/RRethy/nvim-treesitter-textsubjects/pull/53/changes
      # ; will select a syntactical container (class, function, etc.) depending on your location in the syntax tree.
      # i; will select the body of a syntactical container depending on your location in the syntax tree.
      # . will select the most relevant part of the syntax tree depending on your location in it.
      # , repeats the last selection
      #
      # extraPlugins = [
      #   (pkgs.vimUtils.buildVimPlugin {
      #     name = "nvim-treesitter-textsubjects";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "RRethy";
      #       repo = "nvim-treesitter-textsubjects";
      #       rev = "master";
      #       hash = "sha256-gJlM0diDmyvmW5l/QIpUe2bDTZg8XekLBcFOoxeUW4E=";
      #     };
      #   })
      # ];
      # extraConfigLuaPost = ''
      #   require('nvim-treesitter-textsubjects').configure({
      #       prev_selection = ',',
      #       keymaps = {
      #           ['.'] = 'textsubjects-smart',
      #           [';'] = 'textsubjects-container-outer',
      #           ['i;'] = 'textsubjects-container-inner',
      #       },
      #   })
      # '';
    };
}
