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
        # "https://hyprland.cachix.org"
        # "https://cuda-maintainers.cachix.org"
        # "https://ai.cachix.org"
        # "https://ploop.cachix.org" # jaxlib
        # "https://walker-git.cachix.org"
      ];
      # public keys for the caches
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        # "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        # "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
        # "ploop.cachix.org-1:i6+Fqarsbf5swqH09RXOEDvxy7Wm7vbiIXu4A9HCg1g="
        # "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
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
