{
  config,
  pkgs,
  lib,
  ...
}: let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
      };
    };

  plugin = pluginGit "HEAD";
in {
  home.packages = lib.mkIf pkgs.stdenv.isLinux (with pkgs; [xclip]);
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      # LSP and plugins
      nvim-lspconfig
      neodev-nvim
      fidget-nvim

      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
      friendly-snippets

      # Treesitter and more text-objects
      (nvim-treesitter.withPlugins (p: [p.c p.cpp p.nix p.lua p.rust]))
      nvim-treesitter-textobjects

      # Just an example on how to install using pluginGit
      # You have to pass the --impure flag to home-manager in order for this to work
      # (plugin "RRethy/nvim-treesitter-endwise")

      # Git
      vim-fugitive
      vim-rhubarb
      gitsigns-nvim

      # Themes
      rose-pine

      # Status line
      lualine-nvim

      # Indention guides for blank lines
      indent-blankline-nvim

      # vim-commentary
      comment-nvim

      vim-surround
      nvim-autopairs

      # Project manager
      project-nvim

      # Detect tabstop and shiftwidth automatically
      vim-sleuth

      # Floating terminal
      toggleterm-nvim

      # Fuzzy finder
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
    ];
    extraPackages = with pkgs; [
      # LSP servers
      rnix-lsp
      sumneko-lua-language-server
      clang_14
      clang-tools_14
      rust-analyzer

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
