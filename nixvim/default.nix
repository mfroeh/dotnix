{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeModules.default
    ./commands.nix
    ./neovide.nix
    ./keymaps.nix
    ./treesitter.nix
    ./lsp.nix
    ./cmp.nix
    ./zmk.nix
    ./typst.nix
    ./nix.nix
    ./flash.nix
    ./fzf.nix
    ./git.nix
    ./zen.nix
    ./org.nix
    ./go.nix
  ];

  # clipboard providers
  home.packages = with pkgs; [
    xclip
    wl-clipboard
  ];

  programs.nixvim = {
    enable = true;
    clipboard.register = [ "unnamedplus" ];

    plugins.mini-icons = {
      enable = true;
      mockDevIcons = true;
    };

    colorschemes.gruvbox.enable = true;
    colorschemes.gruvbox.settings = {
      terminal_colors = true;
      contrast = "hard";
    };

    plugins.grug-far = {

      enable = true;
      settings = {
        debounceMs = 200;
        engine = "ripgrep";
        settings = {
          engines = {
            ripgrep = {
              path = "rg";
            };
          };
        };
      };
    };

    plugins.harpoon = {
      enable = true;
    };

    plugins.mini-statusline = {
      enable = true;
    };

    plugins.markdown-preview = {
      enable = true;
    };

    plugins.comment.enable = true;
    plugins.nvim-surround.enable = true;

    plugins.oil.enable = true;

    opts = {
      number = true;
      relativenumber = true;

      # indent/tab
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      shiftround = true;
      expandtab = true;

      # search
      ignorecase = true;
      smartcase = true;

      showmode = false;
      laststatus = 3;

      splitright = true;
      splitbelow = true;

      wrap = true;
      linebreak = true;
      showbreak = "↳ ";

      list = false;
      listchars = {
        tab = "▸ ";
        multispace = "·";
        trail = "·";
        extends = "»";
        precedes = "«";
        nbsp = "␣";
        eol = "↵";
      };

      cursorline = true;
      scrolloff = 8;

      gdefault = true;

      autoread = true;

      signcolumn = "yes";

      undofile = true;
      swapfile = false;

      virtualedit = "block";

      # folding: use treesitter for folding, start out buffer with nothing folded
      foldlevelstart = 99;
      foldexpr = "v:lua.vim.treesitter.foldexpr()";
      foldmethod = "expr";
      foldtext = "";

      # neovim default shada
      shada = "!,'100,<50,s10,h";
    };

    plugins.nvim-autopairs.enable = true;
    plugins.rainbow-delimiters.enable = true;

    performance.byteCompileLua = {
      enable = true;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
}
