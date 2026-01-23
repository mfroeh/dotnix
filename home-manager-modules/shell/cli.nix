{
  self,
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      coreutils-full
      # e.g. ld, readelf,
      binutils
      which

      # archivers
      gnutar
      unrar
      gzip
      unzip
      p7zip
      ncompress
      zstd

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

      # hexdump
      xxd
      # compress/decompress between different formats (in particular zlib): `pigz -dcz $YOUR_FILE` decompresses a zlib encoded file to STDOUT
      pigz

      ffmpeg-full
    ]
    ++ [
      (import "${self}/bin/ex.nix" { inherit pkgs; })
      (import "${self}/bin/swatch.nix" { inherit pkgs; })
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

    # [j]ump to directories (cd on a ton of roids)
    zoxide = {
      enable = true;
      options = [ "--no-cmd" ];
    };

    zsh.shellAliases = {
      "j" = "__zoxide_z";
      "ji" = "__zoxide_zi";
      "n" = "__zoxide_z";
      "ni" = "__zoxide_zi";
    };

    # if you try to run a command which does not exist, checks the command against all binaries in nixpkgs/nixos-unstable channel
    nix-index.enable = true;
    # nix-index-database allows us to use a weekly updated cache of the binaries, instead of generating the cache locally using `nix-index` (this takes a few minutes)
    # the comma binary, which we activate here allows us to run `, some-nix-packaged-binary`
    # this simply picks up the binary from `anyPackage/bin/some-nix-packaged-binary`. Install it in nix-profile using -i (don't use this), or open a shell containing the package which contains the binary using (, -s my-binary)
    # this allows you to not have to worry about which package contains which binaries anymore!
    nix-index-database.comma.enable = true;

    zk = {
      enable = true;
      settings = {
        note = {
          language = "en";
          default-title = "Untitled";
          filename = "{{id}}-{{slug title}}";
          extension = "md";
          template = "default.md";
          id-charset = "alphanum";
          id-length = 4;
          id-case = "lower";
        };
        extra = {
          author = "Moritz";
        };
      };
    };
  };
}
