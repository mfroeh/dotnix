{ inputs, ... }:
{
  flake.modules.nixos.nixvim = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.nixvim ];
    programs.neovim.enable = true;
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  flake.modules.homeManager.nixvim =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.nixvim.homeModules.default
        inputs.self.modules.homeManager.neovide
      ];

      programs.nixvim.imports = [
        ./_commands.nix
        ./_keymaps.nix
        ./_lsp.nix
        ./_treesitter.nix
        ./_zmk.nix
        ./_fzf.nix
        ./_git.nix
        ./_org.nix
        ./_flash.nix
        ./_zen.nix
        ./_statusline.nix
        ./_marks.nix

        # TODO: check these again
        ./_cmp.nix
        ./_random.nix

        ./_go.nix
        ./_nix.nix
        ./_typst.nix
        ./_markdown.nix
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };

      programs.zsh.shellAliases = {
        "vi" = "nvim";
        "vim" = "nvim";
      };

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

        # core plugins
        plugins = {
          # until https://github.com/nix-community/nixd/issues/653 closed
          lsp.servers.nixd.package =
            inputs.nixd-completion-in-attr-sets-fix.packages.${pkgs.stdenv.hostPlatform.system}.nixd;

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

      home.packages = lib.mkIf pkgs.stdenv.isLinux (
        with pkgs;
        [
          xclip
          wl-clipboard
        ]
      );
    };
}
