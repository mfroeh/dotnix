{ inputs, ... }:
{
  flake.homeConfigurations = inputs.self.lib.mkHomeManager "x86_64-linux" "work";

  flake.modules.homeManager.work =
    { pkgs, config, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        xdg
        nixvim
        zed
      ];

      home = rec {
        stateVersion = "26.05";
        username = "moritz.froehlich";
        homeDirectory = if pkgs.stdenv.isLinux then "/home/${username}" else "/Users/${username}";
      };

      programs.git = {
        enable = true;
        userName = "Moritz Froehlich";
        userEmail = "moritz.froehlich@freiheit.com";
        extraConfig = {
          init.defaultBranch = "main";
        };
        lfs.enable = true;
      };

      fonts.fontconfig.enable = true;
      services.ssh-agent.enable = true;

      home.file.".ideavimrc".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/jetbrains/.ideavimrc";
    };
}
