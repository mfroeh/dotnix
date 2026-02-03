{
  flake.modules.homeManager.env =
    { pkgs, ... }:
    {
      # a nix environment switcher (acts on .envrc)
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        config = {
          hide_env_diff = true;
        };
      };

      home.packages = [ pkgs.devenv ];
    };
}
