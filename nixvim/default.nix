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
    ./telescope.nix
    ./neotest.nix
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
  ];

  # clipboard providers
  home.packages = with pkgs; [
    xclip
    wl-clipboard
  ];

  programs.nixvim = {
    enable = true;
    clipboard.register = [ "unnamedplus" ];
    extraConfigLua = '''';

    plugins.mini-icons = {
      enable = true;
      mockDevIcons = true;
    };

    plugins.mini-align.enable = true;

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

    extraPlugins = [
      # dont move on yank
      # (pkgs.vimUtils.buildVimPlugin {
      # 	name = "YankAssassin.vim";
      # 	src = pkgs.fetchFromGitHub {
      # 		owner = "svban";
      # 		repo = "YankAssassin.vim";
      # 		rev = "main";
      # 		hash = "sha256-xuQ60dTv+GjU904SB+Nt3tclbNsOycZurdtYZWciD3A=";
      # 	};
      # })
    ];

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

    autoCmd = [
      {
        event = [
          "ModeChanged"
        ];
        callback = {
          __raw = ''function() if vim.api.nvim_get_mode().mode:lower():match 'v' then vim.opt_local.list = true else vim.opt_local.list = false end end'';
        };
      }
    ];

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

    colorschemes.gruvbox.enable = true;
    colorschemes.gruvbox.settings = {
      terminal_colors = true;
      contrast = "hard";
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
