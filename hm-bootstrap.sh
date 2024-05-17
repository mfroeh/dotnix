#!/bin/sh
nix build .#homeConfigurations."$USER@$(hostname)".activationPackage --impure && ./result/activate && rm -rf ./result
