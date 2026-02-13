{ inputs, ... }:
{
  flake.modules.nixos.personalApps =
    { pkgs, ... }:
    {
      home-manager.sharedModules = [ inputs.self.modules.homeManager.personalApps ];

      programs.obs-studio = {
        enable = true;
      };

      environment.systemPackages = with pkgs; [
        coreutils-full
        ntfs3g
        mtpfs
        perf
        discord
        vlc
        gimp
        blender
        ardour
        (jetbrains.goland.override { jdk = pkgs.openjdk21; })
        (jetbrains.rust-rover.override { jdk = pkgs.openjdk21; })

        kdePackages.dolphin
        kdePackages.ark
        kdePackages.gwenview
      ];
    };

  flake.modules.darwin.personalApps = {
    homebrew = {
      enable = true;
      onActivation.cleanup = "uninstall";
      casks = [
        "linearmouse"
        "appcleaner"
        "rectangle"
        "obs"
        # until nix-darwin service fixed
        "karabiner-elements"
      ];
      brews = [ ];
    };
  };

  flake.modules.homeManager.personalApps =
    { config, ... }:
    {
      home.file.".ideavimrc".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotnix/config/jetbrains/.ideavimrc";
    };
}
