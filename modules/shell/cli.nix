{ self, ... }:
{
  flake.modules.homeManager.cli =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        binutils

        gnumake
        just

        which

        dust

        # hexdump
        xxd
        ffmpeg-full

        glow
        neofetch
        asciinema
        asciinema-agg

        (import "${self}/bin/swatch.nix" { inherit pkgs; })

        bat-extras.prettybat
        bat-extras.batgrep

        # for random computations, generally install per project
        ghc
      ];

      programs.less.enable = true;

      programs.bat = {
        enable = true;
      };

      programs.ripgrep = {
        enable = true;
        arguments = [ ];
      };

      # find replacement
      programs.fd = {
        enable = true;
        # search hidden by default
        hidden = true;
        ignores = [ ".git" ];
      };

      programs.eza = {
        enable = true;
        icons = "always";
      };
      programs.fzf = rec {
        enable = true;
        enableZshIntegration = true;
        defaultCommand = fileWidgetCommand;
        fileWidgetCommand = "fd -H --type f";
        changeDirWidgetCommand = "fd -H --type d";
        fileWidgetOptions = [ "--preview 'bat --color=always --plain --line-range=:200 {}'" ];
        historyWidgetOptions = [ ];
      };

      programs.btop = {
        enable = true;
        package = pkgs.btop.override { cudaSupport = true; };
        settings = {
          vim_keys = true;
          update_ms = 500;
        };
      };

      programs.lazygit = {
        enable = true;
        settings = { };
      };

      programs.gh = {
        enable = true;
        settings = {
          git_protocol = "ssh";
        };
      };

      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          line-numbers = true;
          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-decoration-style = "none";
            file-style = "bold yellow ul";
          };
          features = "decorations";
        };
      };

      programs.jq = {
        enable = true;
      };

      programs.zsh.shellAliases = {
        "tree" = "eza --tree";
        "gg" = "lazygit";
      };
    };
}
