{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [lsd bat fzf];
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
    shellAbbrs = {};
    shellAliases = {
      l = "ll";
      cat = "bat";
    };
    plugins = with pkgs.fishPlugins; [
      {
        name = "pure";
        src = pure.src;
      }
      {
        name = "sponge";
        src = sponge.src;
      }
      {
        name = "forgit";
        src = forgit.src;
      }
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
    ];
  };
}
