{
  flake.modules.homeManager.atuin = {
    programs.atuin = {
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

    programs.zsh.initContent = ''
      bindkey -M main '^R' atuin-search
      bindkey -M vicmd '^R' atuin-search
      export ZSH_AUTOSUGGEST_STRATEGY=(atuin completion)
    '';
  };
}
