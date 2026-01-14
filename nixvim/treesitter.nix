{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      grammarPackages =
        pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars
        ++ (with pkgs.tree-sitter-grammars; [
          tree-sitter-norg
          tree-sitter-norg-meta
        ]);
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    plugins.treesitter-context = {
      enable = true;
      settings = {
        max_lines = 2;
      };
    };

    plugins.treesitter-textobjects = {
      enable = true;
      settings = {
        select = {
          enable = true;
          lookahead = true;
          include_surrounding_whitespace = true;
          keymaps = {
            "aa" = "@parameter.outer";
            "ia" = "@parameter.inner";
            "af" = "@function.outer";
            "if" = "@function.inner";
            "am" = "@function.outer";
            "im" = "@function.inner";
            "ac" = "@class.outer";
            "ic" = "@class.inner";
          };
        };
        move = {
          enable = true;
          set_jumps = true;
          goto_previous_start = {
            "[f" = "@function.outer";
            "[m" = "@function.outer";
            "[[" = "@class.outer";
            "[a" = "parameter.outer";
          };
          goto_next_start = {
            "]f" = "@function.outer";
            "]m" = "@function.outer";
            "]]" = "@class.outer";
            "]a" = "parameter.outer";
          };
        };
      };
    };

    # adds indentation textobjects `ii` and `ai` as well as move with `[i` and `]i`
    plugins.indent-tools.enable = true;
  };
}
