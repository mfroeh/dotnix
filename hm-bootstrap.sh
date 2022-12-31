#!/bin/sh
nix build .#homeConfigurations.$1.activationPackage && ./result/activate && rm -rf ./result
