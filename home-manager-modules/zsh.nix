{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    autosuggestion.highlight = "fg=white,underline";

    historySubstringSearch.enable = true;

    zsh-abbr.enable = true;
    zsh-abbr.abbreviations = {
      "gco" = "git checkout";
    };

    autocd = true; # cd /some/dir == /some/dir

    initExtra = ''
      export KEYTIMEOUT=1 # make vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
      bindkey '^F' autosuggest-accept # accept autosuggestions with ^F
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white,underline" # programs.zsh.autosuggestion.highlight sets wrong env variable
    '';

    shellAliases = {
      "ls" = "exa --icons";
      "ed" = "fd | fzf | xargs -r nvim";
      "nre" = "sudo nixos-rebuild switch --flake ~/dotnix";
      "dev" = "nix develop --command zsh";
      "split:" = "tr ':' '\n'";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "vi-mode"
        "tmux"
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
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };
}
