Systems flake with dendritic pattern for my nixos (embedded homeManager), nix-darwin (embedded homeManager) and standalone homeManager systems.

**Configurations**
| Name      | Platform       | OS       | Specs          |
|-----------|----------------|----------|----------------|
| $\lambda$ | x86_64-linux with HM   | NixOS    | 9700k, 1080 Ti |
| xya       | aarch64-darwin with HM | macOS 15 | MacBook Pro 14 |

Build a VM image of the systems configuration and run it

```bash
nix build .#nixosConfigurations.lambda.config.system.build.vm
NIX_DISK_IMAGE=~/test-vm-disk.qcow2 ./result/bin/run-nixos-vm
```

Rules:
* We differentiate between standalone homeManager and system managed homeManager. Only for users that are intended for standalone homeManager use do we create a homeConfiguration, system managed users are embedded with the system configuration.
* If a feature requires both system and homeManager configuration, use the [Multi Context Aspect](https://github.com/Doc-Steve/dendritic-design-with-flake-parts/wiki/Dendritic_Aspects#multi-context-aspect) and then include only the system module in system configurations.
* If a feature requires only a homeManager configuration, only create that and use it in the homeManager configuration.

