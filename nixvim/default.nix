{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.nixvim.homeModules.default
    ./commands.nix
    ./keymaps.nix
    ./lsp.nix
    ./treesitter.nix
    ./zmk.nix
    ./fzf.nix
    ./git.nix
    ./org.nix
    ./neovide.nix
    ./flash.nix
    ./zen.nix
    ./statusline.nix
    ./marks.nix

    # TODO: check these again
    ./cmp.nix
    ./random.nix

    ./go.nix
    ./nix.nix
    ./typst.nix
    ./markdown.nix
  ];

  # clipboard providers on X11/Wayland
  home.packages = lib.optionals pkgs.stdenv.isLinux (
    with pkgs;
    [
      xclip
      wl-clipboard
    ]
  );

  programs.nixvim = {
    enable = true;
    clipboard.register = [ "unnamedplus" ];

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

      # out quickfix list bindings `q...` are ambiguous with the macro stop recording `q` binding (everything else is fine)
      timeoutlen = 1000;
      # time until `CursorHold` fires
      updatetime = 300;
    };

    colorschemes.gruvbox.enable = true;
    colorschemes.gruvbox.settings = {
      terminal_colors = true;
      contrast = "hard";
    };

    # core plugins
    plugins = {
      mini-icons = {
        enable = true;
        mockDevIcons = true;
      };

      nvim-autopairs.enable = true;
      rainbow-delimiters.enable = true;

      comment.enable = true;
      nvim-surround = {
        enable = true;
        settings.keymaps = {
          insert = "<C-g>s";
          normal = "ys";
          normal_cur = "yss";
          visual = "S";
          delete = "ds";
          change = "cs";
        };
        luaConfig.post = ''
          -- Manually delete the mappings nvim-surround forces
          vim.keymap.del("i", "<C-g>S")
          vim.keymap.del("n", "yS")
          vim.keymap.del("n", "ySS")
          vim.keymap.del("n", "cS")
          vim.keymap.del("x", "gS")
        '';
      };

      oil = {
        enable = true;
        settings = {
          # :h oil-columns
          columns = [ "icon" ];
          keymaps = {
            # disabling them is case-sensitive, check https://github.com/stevearc/oil.nvim
            "<C-p>" = false;
          };
        };
      };
    };

    performance.byteCompileLua = {
      enable = true;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
}
