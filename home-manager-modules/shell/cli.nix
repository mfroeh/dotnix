{
  self,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    coreutils-full
    which

    # archivers
    gnutar
    zip
    unzip
    rar

    # bat for man pages
    bat-extras.batman

    dust
    just

    glow

    # nix derivation dependency browser
    nix-tree
    # `nom` is an alias for `nix` with detailled log output
    nix-output-monitor

    devenv

    neofetch

    asciinema
    asciinema-agg
  ];

  programs = {
    nh = {
      enable = true;
      flake = "${self}";
    };

    # cat replacement
    bat = {
      enable = true;
      config = {
        # pick up colors from term
        theme = "ansi";
      };
    };

    # grep replacement
    ripgrep = {
      enable = true;
      arguments = [ ];
    };

    # find replacement
    fd = {
      enable = true;
      # search hidden by default
      hidden = true;
      ignores = [ ".git" ];
    };

    # ls replacement
    eza = {
      enable = true;
      enableZshIntegration = true; # sets a bunch of aliases
      icons = "always";
    };

    # pager
    less.enable = true;

    # man pages
    man.enable = true;

    # tldr (shorter man)
    tealdeer = {
      enable = true;
      settings = {
        updates = {
          auto_update = true;
        };
      };
    };

    # resource monitor
    btop = {
      enable = true;
      package = pkgs.btop.override { cudaSupport = true; };
      settings = {
        color_theme = "gruvbox_dark_v2";
        theme_background = true;
        vim_keys = true;
        update_ms = 500;
      };
    };

    # fuzzy finding is great
    fzf = rec {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = fileWidgetCommand;
      fileWidgetCommand = "fd -H --type f";
      changeDirWidgetCommand = "fd -H --type d";
      fileWidgetOptions = [ "--preview 'bat --color=always --plain --line-range=:200 {}'" ];
      historyWidgetOptions = [ ];
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
      # we bind this manually as otherwise the bindings don't work in vimode
      flags = [
        "--disable-up-arrow"
        "--disable-ctrl-r"
      ];
      settings = {
        # keymap is determined by zsh keymap
        keymap_mode = "auto";
        enter_accept = false;
      };
    };

    lazygit = {
      enable = true;
      settings = { };
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };

    jq = {
      enable = true;
    };

    # a nix environment switcher (acts on .envrc)
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        hide_env_diff = true;
      };
    };

    # terminal file manager
    yazi = {
      enable = true;
      keymap = {
        manager.prepend_keymap = [
          {
            on = "y";
            run = [
              ''shell 'for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list' --confirm''
              "yank"
            ];
          }
        ];
      };
    };
  };
}
