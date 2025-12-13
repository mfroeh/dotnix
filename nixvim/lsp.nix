{
  inputs,
  lib,
  pkgs,
  nixos-config-name,
  home-config-name,
  system,
  ...
}:
{
  programs.nixvim = {
    # starts lsps for embedded code blocks (e.g. lua in nix)
    plugins.otter = {
      enable = true;
      settings.lsp.diagnostic_update_events = [
        "BufWritePost"
        "InsertLeave"
        "TextChanged"
      ];
    };

    # not Neovim native LSP, but still using plugins.lsp since it comes with all the preconfigured server settings
    plugins.lsp = {
      enable = true;
      servers = {
        lua_ls = {
          enable = true;
          settings = {
            runtime.version = "LuaJIT";
            workspace.library = [
              "${pkgs.neovim}/share/nvim/runtime/lua"
            ];
            diagnostics.globals = [ "vim" ];
          };
        };

        tombi = {
          enable = true;
          package = pkgs.tombi;
          packageFallback = true;
        };

        protols = {
          enable = true;
          package = pkgs.protols;
          packageFallback = true;
        };

        jsonls = {
          enable = true;
          package = pkgs.vscode-langservers-extracted;
          packageFallback = true;
        };

        nixd = {
          enable = true;
          # until https://github.com/nix-community/nixd/issues/653 closed
          package = inputs.nixd-completion-in-attr-sets-fix.packages.${system}.nixd;
          settings = {
            formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
            nixpkgs.expr = "import <nixpkgs> {}";
            options = {
              nixos.expr = ''(builtins.getFlake (builtins.toString ~/dotnix)).nixosConfigurations."${nixos-config-name}".options'';
              home-manager.expr = ''(builtins.getFlake (builtins.toString ~/dotnix)).homeConfigurations."${home-config-name}".options'';
              nixvim.expr = ''(builtins.getFlake (builtins.toString ~/dotnix)).inputs.nixvim.nixvimConfigurations."${system}".default.options'';
            };
          };
        };

        gopls = {
          enable = true;
          package = pkgs.gopls;
          packageFallback = true;
        };

        asm_lsp = {
          enable = true;
          package = pkgs.asm-lsp;
          packageFallback = true;
        };

        clangd = {
          enable = true;
          package = pkgs.clang-tools;
          packageFallback = true;
        };

        rust_analyzer = {
          enable = true;
          package = pkgs.rust-analyzer;
          packageFallback = true;
          # rustc and cargo are required by rust_analyzer.
          # we install them once in user scope, but generally will override them with a rust_analyzer from the devshell environment (this only works if packageFallback = true).
          installRustc = true;
          installCargo = true;
        };

        hls = {
          enable = true;
          package = pkgs.haskell-language-server;
          packageFallback = true;
          # same story as with rust_analyzer
          installGhc = true;
        };
      };

      inlayHints = true;

      luaConfig.post = ''
        				vim.diagnostic.config({
        					virtual_text = true,
        					signs = true,
        					underline = true,
        					update_in_insert = false,
        					severity_sort = true,
        				})
        				'';
    };

    plugins.lsp-format.enable = true;

    plugins.fidget.enable = true;

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

    # some more bindings are done with fzf-lua
    keymaps = [
      {
        key = "K";
        mode = [
          "n"
          "v"
        ];
        action = "<cmd>:lua vim.lsp.buf.hover()<cr>";
      }
      {
        # go to definition of symbol under cursor: e.g. symbol is type, go to the type definition, symbol is variable, go to the variable definition
        key = "gd";
        mode = "n";
        action = "<cmd>:lua vim.lsp.buf.definition()<cr>";
      }
      {
        # go to declaration of symbol under cursor: e.g. from function definition jump to function declaration (gd seems to generally work for this too though, where if you are on the definition, gd will jump to the declaration and vice versa)
        key = "gD";
        mode = "n";
        action = "<cmd>:lua vim.lsp.buf.declaration()<cr>";
      }
      {
        # go the the type of the symbol under the cursor: e.g. variable
        key = "gt";
        mode = "n";
        action = "<cmd>:lua vim.lsp.buf.type_definition()<cr>";
      }
      {
        key = "cd";
        mode = "n";
        action = "<cmd>:lua vim.lsp.buf.rename()<cr>";
      }
      {
        key = "<c-.>";
        mode = "n";
        action = "<cmd>:lua vim.lsp.buf.code_action()<cr>";
      }
    ];
  };
}
