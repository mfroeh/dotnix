{
  flake.modules.homeManager.zellij =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      programs.zellij = {
        enable = true;
      };

      xdg.configFile."zellij/config.kdl".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/zellij/config.kdl";

      programs.zsh.sessionVariables = {
        ZELLIJ_AUTO_ATTACH = "false";
        ZELLIJ_AUTO_EXIT = "false";
      };

      programs.zsh.initContent = ''
        if [[ ! -v ZED_TERM ]]; then
          eval "$(${lib.getExe pkgs.zellij} setup --generate-auto-start zsh)"
        fi
      '';
    };
}
