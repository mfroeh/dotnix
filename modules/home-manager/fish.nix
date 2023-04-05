{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ lsd bat fzf xclip ];
  programs.fish = {
    enable = true;
    shellInit = ''
      fish_vi_key_bindings
      bind -M insert \cn down-or-search
      bind -M insert \cp up-or-search
      bind -M insert \cf accept-autosuggestion
    '';
    interactiveShellInit = "";
    shellAbbrs = { };
    shellAliases = {
      l = "ls -la";
      cat = "bat";
      copy = "xclip -sel clip";
      paste = "xclip -sel clip -o ";
      gg = "lazygit";

      nn = "sudo nixos-rebuild switch --flake $HOME/dotnix#$hostname";
      hh = "home-manager switch --flake $HOME/dotnix#$USER@$hostname";
    };
    functions = { mkcd = "mkdir $argv; cd $argv"; };
    plugins = with pkgs.fishPlugins; [
      {
        name = "pure";
        src = pure.src;
      }
      {
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
      {
        name = "sponge";
        src = sponge.src;
      }
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
      {
        name = "plugin-git";
        src = plugin-git.src;
      }
      {
        name = "fish-abbreviation-tips";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fish-abbreviation-tips";
          rev = "8ed76a62bb044ba4ad8e3e6832640178880df485";
          sha256 = "sha256-F1t81VliD+v6WEWqj1c1ehFBXzqLyumx5vV46s/FZRU=";
        };
      }
    ];
  };
}
