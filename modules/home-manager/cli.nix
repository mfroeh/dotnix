{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    ripgrep
    fd
    neofetch
    zip
    unzip
    treefmt
    ltrace
    grive2
  ];

  programs = {
    # cat replacement
    bat.enable = true;

    # ls replacement
    lsd = {
      enable = true;
      enableAliases = true;
    };

    # [j]ump to directories
    zoxide = {
      enable = true;
      options = [ "--cmd j " ];
    };

    # pager
    less.enable = true;

    # man pages
    man.enable = true;

    # git
    lazygit = {
      enable = true;
      settings = { };
    };

    # tldr
    tealdeer = {
      enable = true;
      settings = { updates = { auto_update = true; }; };
    };

    # Resource monitor
    htop = {
      enable = true;
      package = pkgs.htop-vim;
    };

    # Fuzzy finding is great
    fzf = rec {
      enable = true;
      defaultCommand = "${lib.getExe pkgs.fd} -H --type f";
      defaultOptions = [ "--height 50%" ];
      fileWidgetCommand = "${defaultCommand}";
      fileWidgetOptions = [
        "--preview '${
          lib.getExe pkgs.bat
        } --color=always --plain --line-range=:200 {}'"
      ];
      changeDirWidgetCommand = "${lib.getExe pkgs.fd} -H --type d";
      changeDirWidgetOptions =
        [ "--preview '${pkgs.tree}/bin/tree -C {} | head -200'" ];
      historyWidgetOptions = [ ];
    };

    git = {
      enable = true;
      userName = "mfroeh";
      userEmail = "mfroeh0@pm.me";
      aliases = { s = "status"; };
      diff-so-fancy.enable = true;
    };
  };
}
