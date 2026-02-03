{
  flake.modules.nixos.nix = {
    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        # enable community caches
        substituters = [
          "https://nix-community.cachix.org"
          "https://devenv.cachix.org"
        ];
        # public keys for the caches
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        ];
        trusted-users = [
          "root"
          "@wheel"
        ];
        # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
        auto-optimise-store = true;
      };

      # automatically run the nix store optimiser at a specific time
      optimise.automatic = true;

      gc = {
        automatic = true;
        dates = "weekly";
      };
    };
  };
}
