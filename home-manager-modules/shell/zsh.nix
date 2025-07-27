{ lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    autosuggestion.highlight = "fg=yellow";

    historySubstringSearch.enable = true;

    shellAliases = {
      "ed" = "fd . --type f | fzf --preview 'bat {} --color always --plain' | xargs -r nvim";
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

                  function rebuild-system() {
                      local os_name=$(uname -s)

                      if [ "$os_name" = "Linux" ]; then
                          # sudo nixos-rebuild switch --flake ~/dotnix#"$(hostname)"
            							nh os switch ~/dotnix
                      elif [ "$os_name" = "Darwin" ]; then
                          darwin-rebuild switch --flake ~/dotnix#"$(hostname)"
                      fi
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
      ];
      extraConfig = ''
        VI_MODE_SET_CURSOR=true # beam cursor in insert mode
      '';
    };

    history = {
      extended = true; # save timestamps
      ignoreDups = true; # don't add duplicates to history
      ignorePatterns = [ "rm" ];
      ignoreSpace = true; # if command begins with space, don't save
      share = true; # share history between zsh sessions
      save = 10000;
    };

    plugins = [
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

  # expands aliases but is slow as hell, just use `lal`;
  # zsh-abbr.enable = true;
  # zsh-abbr.abbreviations = programs.zsh.shellAliases;
}
