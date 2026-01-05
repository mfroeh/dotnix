{
  self,
  pkgs,
  ...
}:
{
  imports = [ "${self}/users/mo" ];

  system.primaryUser = "mo";
  nix.enable = true;

  # otherwise nix-darwin wont chsh for users (actually, it still doesn't somehow =D, but we want this for nix command completion)
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  system.stateVersion = 4;

  networking.hostName = "xya";
  networking.computerName = "xya";

  services.karabiner-elements.enable = true;

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [
      "linearmouse"
      "appcleaner"
      "rectangle"
      "whatsapp"
      "obs"
    ];
    brews = [ ];
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

      _HIHideMenuBar = true;
    };
  };
}
