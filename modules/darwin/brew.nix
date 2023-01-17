{ config, pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [
      "unnaturalscrollwheels"
      "google-chrome"
      "google-drive"
      "raycast"
      "spotify"
      "balenaetcher"
      "bitwarden"
      "skype"
    ];
  };
}
