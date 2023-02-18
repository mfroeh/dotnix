# My NixOS, Nix-darwin, Home-manager setup
The configuration is split into NixOS/Nix-darwin and standalone Home-manager

### NixOS/Nix-darwin
- The base system configuration is found in `./modules/{nixos,darwin}-base.nix`
- Optional system-level modules are found in `./modules/{nixos,darwin}/`
- Optional system-level modules can be added on a per system basis as imports in `./hosts/${system-name}/default.nix`

### Home-manager
- Most of the configuration is done using Home-manager
- The base Home-manager configuration is found in `./modules/home-manager/{nixos,darwin}-base.nix`
- Optional modules for darwin and nix are found in `./modules/home-manager/{nixos,darwin}/`
- Optional modules for both systems are found in `./modules/home-manager/common/`
- Languages can be configured using `./modules/home-manager/languages.nix`
- Optional modules and languages can be enabled in `flake.nix`

## Systems
| Name      | Platform       | OS       | Specs          |
|-----------|----------------|----------|----------------|
| gus       | aarch64-darwin | macOS 13 | MacBook Pro 14 |
| herc      | x86_64-linux   | NixOS    | 7700k, 1080    |
| $\eta$    | aarch64-linux  | NixOS    | MacBook Pro 14 |
| $\lambda$ | x86_64-linux   | NixOS    | 9700k, 1080 Ti |
| $\pi$     | aarch64-linux  | NixOS    | Raspberry Pi 4 |
| wsl       | x86_64-linux   | NixOS (wsl) | 7700k, 1080 Ti |
