{ self, inputs, ... }:
{
  flake.modules.homeManager.nixRelated =
    { ... }:
    {
      # weekly updated nix-index database for nixpkgs/nixos-unstable channel
      imports = [ inputs.nix-index-database.homeModules.default ];

      programs.nh = {
        enable = true;
        flake = "${self}";
      };

      programs.zsh.shellAliases = {
        # "ho" = "home-manager switch --flake ~/dotnix#$USERNAME@$(hostname)";
        "ho" = "nh home switch ~/dotnix";
        "so" = "rebuild-system";
        "dev" = "nix develop --command zsh";
      };
      programs.zsh.initContent = ''
        function rebuild-system() {
            local os_name=$(uname -s)
            if [ "$os_name" = "Linux" ]; then
                # sudo nixos-rebuild switch --flake ~/dotnix#"$(hostname)"
                nh os switch ~/dotnix
            elif [ "$os_name" = "Darwin" ]; then
                # darwin-rebuild switch --flake ~/dotnix#"$(hostname)"
                nh darwin switch ~/dotnix
            fi
        }
      '';

      # if you try to run a command which does not exist, checks the command against all binaries in nixpkgs/nixos-unstable channel
      # provides bin/nix-locate, which you can use like `nix-locate -r bin/make$` (where -r is for using regex)
      programs.nix-index.enable = true;
      # nix-index-database allows us to use a weekly updated cache of the binaries, instead of generating the cache locally using `nix-index` (this takes a few minutes)
      # the comma binary, which we activate here allows us to run `, some-nix-packaged-binary`
      # this simply picks up the binary from `anyPackage/bin/some-nix-packaged-binary`. Install it in nix-profile using -i (don't use this), or open a shell containing the package which contains the binary using (, -s my-binary)
      # this allows you to not have to worry about which package contains which binaries anymore!
      programs.nix-index-database.comma.enable = true;
    };
}
