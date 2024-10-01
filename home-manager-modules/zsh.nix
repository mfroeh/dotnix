{ pkgs, ... }: rec {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    autosuggestion.highlight = "fg=yellow";

    historySubstringSearch.enable = true;

    shellAliases = {
      "ed" = "fd . --type f | fzf --preview='bat {} --color always --plain' | xargs -r nvim";
      "nre" = "sudo nixos-rebuild switch --flake ~/dotnix";
      "dre" = "darwin-rebuild switch --flake ~/dotnix";
      "dev" = "nix develop --command zsh";
      "gg" = "lazygit";
      "split:" = "tr ':' '\n'";
      "tree" = "eza --tree";
    };

    autocd = true; # cd /some/dir == /some/dir, cd ../.. == ...

    initExtra = ''
      export KEYTIMEOUT=1 # make vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
      bindkey '^F' autosuggest-accept # accept autosuggestions with ^F
    '';

    zsh-abbr.enable = true;
    zsh-abbr.abbreviations = programs.zsh.shellAliases;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "vi-mode" # adds better vi mode (e.g. change cursor style depending on mode)
        "tmux" # adds aliases and ZSH_TMUX_AUTOSTART functionality
        "git" # adds aliases and some functions, https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
      ];
      extraConfig = ''
        ZSH_TMUX_AUTOSTART=true # automatically start tmux
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

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = true;
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

  # a nix environment switcher
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      hide_env_diff = true;
    };
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd j" ];
  };
}
