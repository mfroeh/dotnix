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
    plugins.lsp = {
      enable = true;

      servers = {
        # tombi = {
        #   enable = true;
        #   package = pkgs.tombi;
        #   packageFallback = true;
        # };

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
          # until https://github.com/nix-community/nixd/issues/653 closed
          package = inputs.nixd-completion-in-attr-sets-fix.packages.${system}.nixd;
          enable = true;
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
  };
}
