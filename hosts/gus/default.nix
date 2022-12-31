# hosts/YourHostName/default.nix
{
  pkgs,
  home-manager,
  self,
  ...
}: {
  networking.hostName = "gus";

  # users.users.mo = {
  #   home = "/Users/mo";
  #   shell = pkgs.fish; # TODO: Doesn't work
  # };
}
