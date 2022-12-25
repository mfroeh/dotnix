# hosts/YourHostName/default.nix
{ pkgs, home-manager, ... }:
{
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  
  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  programs.zsh.enable = true;
  programs.fish.enable = true;

system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;
  # system.keyboard.remapCapsLockToEscape = true;

  services.karabiner-elements.enable = true;

  users.users.mo = {
	home = "/Users/mo";
	shell = pkgs.fish;
};

homebrew = {
  enable = true;
  autoUpdate = true;
  # updates homebrew packages on activation,
  # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
  casks = [
    "hammerspoon"
    "amethyst"
    "alfred"
    "logseq"
    "discord"
    "iina"
  ];
};

system.defaults.dock.autohide = true;


}
