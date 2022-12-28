{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      # LSP and plugins
      nvim-lspconfig
      fidget-nvim
      neodev-nvim

      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp_luasnip

      # Treesitter and more text-objects
      (nvim-treesitter.withPlugins (p: [p.c p.cpp p.nix p.lua]))
      nvim-treesitter-textobjects

      # Git
      vim-fugitive
      vim-rhubarb
      gitsigns-nvim

      # Theme
      onedark-nvim

      # Status line
      lualine-nvim

      # Indention guides for blank lines
      indent-blankline-nvim

      # vim-commentary
      comment-nvim

      # Detect tabstop and shiftwidth automatically
      vim-sleuth

      # Fuzzy finder
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
    ];
    extraPackages = with pkgs; [
      # LSP servers
      rnix-lsp
      sumneko-lua-language-server

      # Treesitter
      tree-sitter

      # Tools used by plugins
      ripgrep
      fd
    ];
  };

  xdg.configFile.nvim = {
    source = ../../config/nvim;
    recursive = true;
  };
}
