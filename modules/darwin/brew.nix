{pkgs, ...}: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [
      "unnaturalscrollwheels"
      "google-chrome"
      "google-drive"
      "raycast"
    ];
  };
}
