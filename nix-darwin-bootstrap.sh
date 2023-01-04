#!/bin/sh

cd $HOME
echo "Installing nix-darwin, say 'n' to everything but creation of /run"
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer && ./result/bin/darwin-installer && rm -rf ./result

echo "Backing up /etc/nix/nix.conf and /etc/shells since we will manage them using nix-darwin"
sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.backup
sudo mv /etc/shells /etc/shells.backup

echo "Building nix flake for $1"
nix-shell -p git
git clone https://github.com/mfroeh/dotnix2 dotnix && cd dotnix && nix build .#darwinConfigurations.$1.system --extra-experimental-features "nix-command flakes" && ./result/sw/bin/darwin-rebuild switch .#$1 && cd $HOME
exit

echo "All done to bootstrap home-manager run './hm-bootstrap.sh mo@$1'"
