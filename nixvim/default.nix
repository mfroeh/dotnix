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
    ./typst.nix
    ./nix.nix
    ./flash.nix
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
      (pkgs.vimUtils.buildVimPlugin {
        name = "srcery-vim";
        src = pkgs.fetchFromGitHub {
          owner = "srcery-colors";
          repo = "srcery-vim";
          rev = "master";
          hash = "sha256-lChTwlcJ69Cjvg7l7KsPn/3b16cInwxvYFriWT1BmqE=";
        };
      })
    ];

    plugins.harpoon = {
      enable = true;
    };

    # https://github.com/swaits/zellij-nav.nvim/
    plugins.zellij-nav = {
      enable = true;
    };

    plugins.markdown-preview = {
      enable = true;
    };

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

    colorschemes.gruvbox.enable = true;
    colorschemes.gruvbox.settings = {
      terminal_colors = true;
      contrast = "hard";
    };

    plugins.web-devicons.enable = true;

    plugins.nvim-autopairs.enable = true;
    plugins.rainbow-delimiters.enable = true;

    plugins.comment.enable = true;

    extraConfigLuaPost = ''
      -- Somewhere in your Nixvim Lua config
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "NvimConfig.lua",
        callback = function()
          -- Add a helpful header and map a key to source the buffer
          vim.api.nvim_buf_set_lines(0, 0, 0, false, {
            "-- This is a scratchpad for testing Neovim config.",
            "-- Press <leader>s to source this buffer.",
            "-- This will reload any functions or mappings you define here.",
            "local M = {}",
            "M.go_to_test_file = function()",
            "  -- Your prototype function code here...",
            "end",
            "return M",
          })
          vim.keymap.set("n", "<leader>s", ":source %<CR>", { silent = true, desc = "Source current buffer" })
          vim.cmd("setlocal filetype=lua")
        end,
        desc = "Setup scratchpad buffer for config testing",
      })
            		'';

    performance.byteCompileLua = {
      enable = false;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
}
