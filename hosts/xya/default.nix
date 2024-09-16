{ self, inputs, specialArgs, ... }:
with inputs;
{
  imports = [
    inputs.mac-app-util.darwinModules.default
    "${self}/users/mo"
    home-manager.darwinModules.home-manager
    {
      home-manager.sharedModules =
        [ mac-app-util.homeManagerModules.default ];
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = specialArgs;
      home-manager.backupFileExtension = ".backup";
      home-manager.users.mo = import "${self}/users/mo/home.nix";
    }
  ];

  # otherwise nix-darwin wont chsh for users (actually, it still doesn't somehow =D, but we want this for nix command completion)
  programs.zsh.enable = true;

  system.stateVersion = 4;

  networking.hostName = "xya";
  networking.computerName = "xya";

  services.nix-daemon.enable = true;
  services.karabiner-elements.enable = true;

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [
      "google-chrome"
      "bitwarden"
      "linearmouse"
      "appcleaner"
      "rectangle"
      "wine-stable"
      "pgadmin4"
      "whatsapp"
      "chatgpt"
      "obs"
    ];
    brews = [
    ];
  };

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
    };

    NSGlobalDomain = {
      # Use key repeat over press and hold
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 1;
      InitialKeyRepeat = 15;

      # Hide the menu bar
      _HIHideMenuBar = true;
    };
  };
}
