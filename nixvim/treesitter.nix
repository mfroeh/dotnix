{ pkgs, config, ... }:
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

    plugins.treesitter-context.enable = true;

    plugins.treesitter-textobjects = {
      enable = true;
      select = {
        enable = true;
        lookahead = true;
        includeSurroundingWhitespace = true;
        keymaps = {
          "aa" = "@parameter.outer";
          "ia" = "@parameter.inner";
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
        };
      };
      move = {
        enable = true;
        setJumps = true;
        gotoPreviousStart = {
          "[f" = "@function.outer";
          "[[" = "@class.outer";
          "[a" = "parameter.outer";
        };
        gotoNextStart = {
          "]f" = "@function.outer";
          "]]" = "@class.outer";
          "]a" = "parameter.outer";
        };
      };
    };
  };
}
