# My NixOS, Nix-Darwin, Home-Manager Setup

## Systems
| Name      | Platform       | OS       | Specs          |
|-----------|----------------|----------|----------------|
| xya       | aarch64-darwin | macOS 15 | MacBook Pro 14 |
| $\lambda$ | x86_64-linux   | NixOS    | 9700k, 1080 Ti |

## Nix-darwin bootstrap
`nix run --extra-experimental-features "nix-command flakes" nix-darwin -- switch --flake .#xya`

## Home-manager bootstrap
`nix run github:nix-community/home-manager -- switch --flake .#$USERNAME@$(hostname)`