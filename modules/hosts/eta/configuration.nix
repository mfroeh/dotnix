{
  inputs,
  ...
}:
{
  flake.darwinConfigurations = inputs.self.lib.mkDarwin "aarch64-darwin" "eta";

  flake.modules.darwin.eta = {
    imports = with inputs.self.modules.darwin; [
      locale
      remaps
      mo

      personalApps
      shell
      stylix
      nixvim
    ];

    system.stateVersion = 6;
    ids.gids.nixbld = 30000;

    networking.hostName = "eta";
    networking.computerName = "eta";

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
  };
}
