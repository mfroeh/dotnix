{ ... }:
{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;

      servers = {
        nixd.enable = true;
        gopls.enable = true;
        protols.enable = true;

        harper_ls = {
          enable = true;
          # https://writewithharper.com/docs/integrations/neovim#Optional-Configuration
          settings.harper-ls = {
            userDictPath = "~/harper-user-dict.txt";
            linters = {
              spell_check = false;
              sentence_capitalization = false;
            };
          };
        };

        jsonls.enable = true;

        rust_analyzer.enable = true;
        # install this per project instead
        rust_analyzer.installRustc = false;
        rust_analyzer.installCargo = false;
      };
      # plugins.lsp.inlayHints = true;
      luaConfig.post = ''
        				vim.diagnostic.config({
        					virtual_text = true,
        					signs = true,
        					underline = true,
        					update_in_insert = false,
        					severity_sort = true,
        				})
        				'';

      keymaps.lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
        cd = "rename";
      };
    };

    plugins.lsp-format.enable = true;

    plugins.lsp-signature = {
      enable = true;
      settings = {
        # also show when parameters are split across multiple lines
        always_trigger = true;
        handler_opts = {
          border = "none";
        };
        doc_lines = 0;
      };
    };

    # some options here https://github.com/elythh/nixvim/blob/old/modules/nixvim/plug/lspsaga/default.nix
    plugins.lspsaga = {
      enable = true;
      codeAction = {

      };
      lightbulb = {
        enable = true;
        # show in status column
        sign = true;
        # dont show inline
        virtualText = false;
      };
    };

    keymaps = [
      {
        mode = [
          "v"
          "i"
          "n"
        ];
        key = "<c-.>";
        action = "<cmd>Lspsaga code_action<cr>";
      }
    ];

  };
}
