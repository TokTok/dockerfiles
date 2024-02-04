#!/bin/sh

set -eux

# Install nix if it's not there yet (e.g. on Github Actions).
if ! which nix-shell; then
  curl -L https://nixos.org/nix/install -o install.sh
  sh install.sh --no-daemon --no-channel-add --yes
  rm install.sh
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  nix-channel --add https://github.com/NixOS/nixpkgs/archive/refs/tags/23.11.tar.gz nixpkgs
  nix-channel --update
fi

# Build a docker image and squash all the layers.
nix-shell -p arion --run 'arion build'
IMAGE=$(nix-shell -p arion --run 'arion config' | grep -o 'toxchat/bazel:.*')
mkdir layers
docker save "$IMAGE" | tar x -C layers
tar cf squashed.tar README.md
for i in layers/*/layer.tar; do
  tar -Af squashed.tar "$i"
done
# Delete the separate layers after squashing them.
rm -r layers

# Run docker build, then clean up if we built the tarball above.
docker build -t toxchat/bazel:latest .
