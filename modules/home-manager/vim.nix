{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
          # Pure text editing
          vim-surround
          vim-commentary
          vim-subversive
          vim-easy-align
          targets-vim
          auto-pairs

          # Additional text objects
          vim-textobj-user
          vim-textobj-comment

          # More tool/language independent
          fzf-vim
          gruvbox-material

          # Languages
          vim-nix
        ];
        extraConfig = builtins.readFile ./init.vim;
      };
    }
