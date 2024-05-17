deploy:
  sudo nixos-rebuild switch --flake .

debug:
  sudo nixos-rebuild switch --flake . --show-trace --verbose

up:
  nix flake update

# Update specific input
# usage: just upp i=home-manager
upp:
  nix flake lock --update-input $(i)

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage --delete-old
