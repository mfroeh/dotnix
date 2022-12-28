{pkgs, ...}: {
  nix.extraOptions = "experimental-features = nix-command flakes";

  imports = [./system-defaults.nix ./brew.nix ./yabai.nix ./skhd.nix ./spacebar.nix ./wallpaper.nix];

  # wallpaper = {
  #   enable = true;
  #   file = "/Users/mo/nix.png";
  # };

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  services.karabiner-elements.enable = true;

  environment = {
    loginShell = "${pkgs.fish}/bin/fish";
    variables = {
      editor = "nvim";
    };
  };

  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  environment.shells = with pkgs; [fish zsh bashInteractive];

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["RobotoMono"];})
  ];

  environment.systemPackages = with pkgs; [
    neovim
  ];

  system.stateVersion = 4;
}
