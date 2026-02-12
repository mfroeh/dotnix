{
  flake.modules.nixos.zsh =
    { pkgs, ... }:
    {
      programs.zsh.enable = true;
      users.defaultUserShell = pkgs.zsh;
    };

  flake.modules.darwin.zsh =
    { pkgs, ... }:
    {
      environment.shells = [ pkgs.zsh ];
    };

  flake.modules.homeManager.zsh =
    { pkgs, ... }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;

        syntaxHighlighting.enable = true;
        autosuggestion.enable = true;
        autosuggestion.highlight = "fg=#FFA500,underline,bold";

        historySubstringSearch.enable = true;

        shellAliases = {
          "lal" = "alias | fzf";
          # e.g. nix path-info nixpkgs#firefox - also works with nix wrapped binaries (generally shell scripts): e.g. nix path-info $(which myBinary)
          "npi" = "nix path-info";
          "gfh" = "git-file-history";

          # TODO at some point maybe move this together with the nixvim config once we've migrated it to flake-parts modules
          "journal" = ''nvim -c "lua vim.api.nvim_input('<Space>jn')"'';
          "braindump" = ''nvim -c "lua vim.api.nvim_input('<Space>bd')"'';
        };

        autocd = true; # cd /some/dir == /some/dir, cd ../.. == ...

        initContent = ''
          export KEYTIMEOUT=1 # make vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
          bindkey '^F' autosuggest-accept # accept autosuggestions with ^F
          export ZSH_AUTOSUGGEST_USE_ASYNC=1

          function git-file-history() {
            git rev-list HEAD -- "$1" | while read hash; do
              git --no-pager show --pretty="format:%H: %B" --no-patch $hash
              git --no-pager show "$hash:$1"
              echo "\n"
            done
          }

          if [[ -f ~/.zshrc.local ]]; then
            source ~/.zshrc.local
          fi
        '';

        oh-my-zsh = {
          enable = true;
          plugins = [
            "vi-mode" # adds better vi mode (e.g. change cursor style depending on mode)
            "git" # adds aliases and some functions, https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
            "gcloud"
            "fancy-ctrl-z" # <c-z> now is a toggle for suspending/resuming jobs
          ];
          extraConfig = ''
            VI_MODE_SET_CURSOR=true # beam cursor in insert mode
          '';
        };

        plugins = [
          # replaces the zsh completion menu with fzf
          # must be before plugins that wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting
          {
            name = "fzf-tab";
            src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
          }
          # sets IN_NIX_SHELL which is used by starship
          {
            name = "zsh-nix-shell";
            file = "nix-shell.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "chisui";
              repo = "zsh-nix-shell";
              rev = "v0.8.0";
              sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
            };
          }
        ];
      };

      # starship - an customizable prompt for any shell
      programs.starship = {
        enable = true;
        settings = {
          add_newline = false;
          line_break.disabled = true;
          nix_shell.format = "in 󰜗 "; # the default icon causes issues with zsh-autosuggestion
        };
      };
    };
}
