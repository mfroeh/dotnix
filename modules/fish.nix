{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellInit = ''
      fish_vi_key_bindings
      bind -M insert \cn down-or-search
      bind -M insert \cp up-or-search
      bind -M insert \cf accept-autosuggestion
    '';
    shellAbbrs = { };
    shellAliases = { };
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
