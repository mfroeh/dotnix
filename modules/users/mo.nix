{ inputs, ... }:
{
  flake.modules.nixos.mo =
    { ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.self.modules.nixos.usersGeneric
      ];

      users.users.mo = {
        description = "mfroeh";
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        initialPassword = "";
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = ".backup";
        users.mo = inputs.self.modules.homeManager.mo;
      };
    };

  flake.modules.darwin.mo =
    { ... }:
    {
      imports = [ inputs.home-manager.darwinModules.home-manager ];

      # shell has to bet set manually using chsh, as nix-darwin will only do it for nix-darwin managed users
      users.users.mo = {
        description = "mfroeh";
        home = "/Users/mo";
      };
      system.primaryUser = "mo";

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = ".backup";
        users.mo = inputs.self.modules.homeManager.mo;
      };
    };

  flake.modules.homeManager.mo =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        xdg
        zed
        firefox
        ghostty
      ];

      home = rec {
        stateVersion = "26.05";
        username = "mo";
        homeDirectory = if pkgs.stdenv.isLinux then "/home/${username}" else "/Users/${username}";
      };

      programs.git = {
        enable = true;
        settings = {
          user.name = "mfroeh";
          user.email = "mfroeh0@pm.me";
          init.defaultBranch = "main";
        };
        lfs.enable = true;
      };

      programs.mangohud = {
        enable = pkgs.stdenv.isLinux;
        enableSessionWide = true;
        settingsPerApplication = {
          vlc = {
            no_display = true;
          };
        };
      };

      home.packages = with pkgs; [
        neohtop
        leetcode-cli
        (google-cloud-sdk.withExtraComponents (
          with google-cloud-sdk.components; [ gke-gcloud-auth-plugin ]
        ))
      ];

      fonts.fontconfig.enable = true;
      services.ssh-agent.enable = true;
    };
}
