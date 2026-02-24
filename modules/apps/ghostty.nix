{
  flake.modules.homeManager.ghostty =
    { pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;
        package = if pkgs.stdenv.isLinux then pkgs.ghostty else pkgs.ghostty-bin;
        enableZshIntegration = true;
        settings = {
          app-notifications = false;
          confirm-close-surface = false;
          keybind = "ctrl+,=unbind";
        };
      };
    };
}
