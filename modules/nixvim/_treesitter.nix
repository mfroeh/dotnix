{ pkgs, ... }:
{
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
        include_surrounding_whitespace = false;
        keymaps = {
          "aa" = "@parameter.outer";
          "ia" = "@parameter.inner";
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ie" = "@element.inner";
          "ae" = "@element.outer";
          "aC" = "@class.outer";
          "iC" = "@class.inner";
        };
      };
      move = {
        enable = true;
        set_jumps = true;
        goto_previous_start = {
          "[[" = "@function.outer";
          "[f" = "@function.outer";
          "[C" = "@class.outer";
          "[a" = "parameter.outer";
        };
        goto_next_start = {
          "]]" = "@function.outer";
          "]f" = "@function.outer";
          "]C" = "@class.outer";
          "]a" = "parameter.outer";
        };
      };
    };
  };

  extraFiles = {
    "queries/nix/textobjects.scm".source = ./queries/nix/textobjects.scm;
    "queries/go/textobjects.scm".source = ./queries/go/textobjects.scm;
  };

  # adds indentation textobjects `ii` and `ai` as well as move with `[i` and `]i`
  plugins.indent-tools.enable = false;

  keymaps = [
    {
      key = "[x";
      mode = "n";
      action = ":lua require('treesitter-context').go_to_context(vim.v.count1)<cr>";
    }
  ];
}
