# hosts/YourHostName/default.nix
{
  pkgs,
  home-manager,
  self,
  ...
}: {
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  networking.hostName = "gus";

  users.users.mo = {
    home = "/Users/mo";
    shell = pkgs.fish; # TODO: Doesn't work
  };

  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  environment.shells = with pkgs; [fish zsh bashInteractive];
}
