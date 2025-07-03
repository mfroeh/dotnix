{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeModules.default
    ./keymaps.nix
    ./treesitter.nix
    ./telescope.nix
    ./neotest.nix
    ./lsp.nix
    ./cmp.nix
    ./zmk.nix
  ];

  programs.neovide = {
    enable = true;
    settings = {
      maximized = true;
      font = {
        normal = [ "Hack Nerd Font Mono" ];
        size = 12;
      };
    };
  };

  # clipboard providers
  home.packages = with pkgs; [
    xclip
    wl-clipboard
  ];

  programs.nixvim = {
    enable = true;

    extraConfigLua = '''';

    clipboard.register = [ "unnamedplus" ];

    plugins.lualine.enable = true;

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

    plugins.neorg.enable = true;
    plugins.neorg.settings.load = {
      "core.concealer" = {
        config = {
          icon_preset = "varied";
        };
      };
      "core.dirman" = {
        config = {
          workspaces = {
            mine = "~/notes";
          };
          default_workspace = "mine";
        };
      };
      "core.journal" = {
        config = {
          strategy = "flat";
          workspace = "mine";
        };
      };
    };

    plugins.lazygit.enable = true;
    plugins.gitsigns.enable = true;
    plugins.gitsigns.settings.current_line_blame = true;

    keymaps = [
      {
        mode = "n";
        key = "gm";
        action = "<cmd>LazyGit<cr>";
      }
      {
        mode = "n";
        key = "[c";
        action = "<cmd>Gitsigns nav_hunk prev<cr>";
      }
      {
        mode = "n";
        key = "]c";
        action = "<cmd>Gitsigns nav_hunk next<cr>";
      }
    ];

    plugins.zen-mode.enable = true;

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

      list = true;
      listchars = {
        # tab = "▸ ";
        tab = "  ";
        # multispace = "·";
        trail = "·";
        extends = "»";
        precedes = "«";
        nbsp = "␣";
        # eol = "↵";
      };

      cursorline = true;
      scrolloff = 8;

      gdefault = true;

      autoread = true;

      signcolumn = "yes";

      undofile = true;
      swapfile = false;

      virtualedit = "block";
    };

    globals = {
      # disable all neovide animations
      neovide_position_animation_length = 0;
      neovide_cursor_animation_length = 0.00;
      neovide_cursor_trail_size = 0;
      neovide_cursor_animate_in_insert_mode = false;
      neovide_cursor_animate_command_line = false;
      neovide_scroll_animation_far_lines = 0;
      neovide_scroll_animation_length = 0.00;
    };

    colorschemes = {
      nightfox.enable = true;
      # “carbonfox”, “dawnfox”, “dayfox”, “duskfox”, “nightfox”, “nordfox”, “terafox”
      nightfox.flavor = "nightfox";
    };

    plugins.web-devicons.enable = true;

    plugins.nvim-autopairs.enable = true;
    plugins.rainbow-delimiters.enable = true;

    plugins.comment.enable = true;

    # TODO
    performance.byteCompileLua = {
      enable = false;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
}
