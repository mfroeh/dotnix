{
  config,
  pkgs,
  lib,
  ...
}: let
  # installs a vim plugin from git with a given tag / branch
# Needs --impure flag 
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
  home.packages = [ pkgs.neovide ] ++ lib.optionals pkgs.stdenv.isLinux (with pkgs; [xclip]);
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = false;
    plugins = with pkgs.vimPlugins; [
      # LSP and plugins
      nvim-lspconfig
      neodev-nvim
      fidget-nvim

      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      cmp-buffer
      luasnip
      cmp_luasnip
      friendly-snippets

      # Treesitter and plugins
      (nvim-treesitter.withPlugins (p: [p.c p.cpp p.nix p.lua p.rust]))
      nvim-treesitter-textobjects
      nvim-ts-rainbow

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

      # Neccessary plugins
      comment-nvim
      vim-surround
      nvim-autopairs

      # Quickfix
      # nvim-bqf

      # Detect tabstop and shiftwidth automatically
      vim-sleuth

      # Floating terminal
      toggleterm-nvim

      # Telescope and plugins
      # plenary-nvim
      telescope-nvim
      telescope-zoxide
      telescope-fzf-native-nvim

      # Plugins with telescope extensions
      project-nvim
      nvim-neoclip-lua
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

      # Tools used by telescope
      ripgrep
      bat
      fd
      fzf
    ];
    extraLuaPackages = with pkgs.lua53Packages; [plenary-nvim];
  };

  xdg.configFile.nvim = {
    source = ../../config/nvim;
    recursive = true;
  };
}
