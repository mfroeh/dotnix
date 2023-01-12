{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ lsd bat fzf xclip ];
  programs.fish = {
    enable = true;
    shellInit = ''
      fish_vi_key_bindings
      bind -M insert \cn down-or-search
      bind -M insert \cp up-or-search
      bind -M insert \cf accept-autosuggestion
      bind -M insert \ca beginning-of-line
      bind -M insert \ce end-of-line
    '';
    shellAbbrs = { };
    shellAliases = {
      l = "ls -la";
      cat = "bat";
      copy = "xclip -sel clip";
      paste = "xclip -sel clip -o ";
      gg = "lazygit";

      nn = "sudo nixos-rebuild switch --flake $HOME/dotnix#$hostname";
      hh = "home-manager switch --flake $HOME/dotnix#$USER@$hostname";

      gnomeCtrlCenter =
        "WEBKIT_DISABLE_COMPOSITING_MODE=1 MESA_LOADER_DRIVER_OVERRIDE=zink gnome-control-center online-accounts";
    };
    functions = { mkcd = "mkdir $argv; cd $argv"; };
    plugins = with pkgs.fishPlugins; [
      {
        name = "pure";
        src = pure.src;
      }
      {
        name = "fzf-fish";
        src = fzf-fish.src;
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
        name = "forgit";
        src = forgit.src;
      }
    ];
  };
}
