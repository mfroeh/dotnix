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
      "so" = "rebuild-system";
      # "ho" = "home-manager switch --flake ~/dotnix#$USERNAME@$(hostname)";
      "ho" = "nh home switch ~/dotnix";
      "dev" = "nix develop --command zsh";
      "gg" = "lazygit";
      "tree" = "eza --tree";
      "man" = "batman";
      "lal" = "alias | fzf";
      "vim" = "nvim";
      "vi" = "nvim";
      "nv" = "neovide";
      # e.g. nix path-info nixpkgs#firefox - also works with nix wrapped binaries (generally shell scripts): e.g. nix path-info $(which myBinary)
      "npi" = "nix path-info";
      "gfh" = "git-file-history";
    };

    sessionVariables = {
      EDITOR = "nvim";
    };

    autocd = true; # cd /some/dir == /some/dir, cd ../.. == ...

    initContent = ''
      export KEYTIMEOUT=1 # make vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
      bindkey '^F' autosuggest-accept # accept autosuggestions with ^F
      bindkey -M main '^R' atuin-search
      bindkey -M vicmd '^R' atuin-search
      export ZSH_AUTOSUGGEST_STRATEGY=(atuin completion)
      export ZSH_AUTOSUGGEST_USE_ASYNC=1

      function rebuild-system() {
          local os_name=$(uname -s)

          if [ "$os_name" = "Linux" ]; then
              # sudo nixos-rebuild switch --flake ~/dotnix#"$(hostname)"
              nh os switch ~/dotnix
          elif [ "$os_name" = "Darwin" ]; then
              # darwin-rebuild switch --flake ~/dotnix#"$(hostname)"
              nh darwin switch ~/dotnix
          fi
      }

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
}
