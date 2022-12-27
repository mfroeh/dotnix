{pkgs, ...}: {
  imports = [./system-defaults.nix ./brew.nix ./yabai.nix ./skhd.nix ./spacebar.nix];

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  services.karabiner-elements.enable = true;

  environment = {
    loginShell = pkgs.fish;
    variables = {
      editor = "nvim";
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["RobotoMono" "DroidSansMono"];})
  ];

  system.stateVersion = 4;
}
