{ pkgs, lib, ... }:
{
  nix = {
    settings = {
      # enable new nix cli and flakes
      experimental-features = [
        "nix-command"
        "flakes"
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
      trusted-users = [ "root mo" ];
      # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
      auto-optimise-store = pkgs.stdenv.isLinux;
    };

    # automatically run the nix store optimiser at a specific time
    optimise.automatic = true;

    gc =
      lib.mkIf pkgs.stdenv.isLinux {
        automatic = true;
      }
      // lib.optionalAttrs pkgs.stdenv.isLinux {
        dates = "weekly";
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        interval = [
          {
            Hour = 0;
            Minute = 0;
            Weekday = 7;
          }
        ];
      };
  };
}
