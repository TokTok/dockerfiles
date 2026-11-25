#!/bin/sh

set -eux

# Install nix if it's not there yet (e.g. on Github Actions).
if ! which nix-shell; then
  curl -L https://nixos.org/nix/install -o install.sh
  sh install.sh --no-daemon --no-channel-add --yes
  rm install.sh
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  nix-channel --add https://github.com/NixOS/nixpkgs/archive/2786a2a72088ecf32aea5b3ec52099e6a7cff78f.tar.gz nixpkgs
  nix-channel --update
fi

# Build a docker image.
nix-shell -p arion --run 'arion build'
IMAGE="$(nix-shell -p arion --run 'arion config' | grep -o 'ghcr.io/toktok/bazel:.*')"

docker tag "$IMAGE" "ghcr.io/toktok/bazel:base"

mkdir layers
docker save "ghcr.io/toktok/bazel:base" | tar -x -C layers
