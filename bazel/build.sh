#!/bin/sh

set -eux

# Install nix if it's not there yet (e.g. on Github Actions).
if ! which nix-shell; then
  curl -L https://nixos.org/nix/install -o install.sh
  sh install.sh --no-daemon --no-channel-add --yes
  rm install.sh
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  nix-channel --add https://github.com/NixOS/nixpkgs/archive/a81bbdfb658428a45c69a42aa73d4bd18127c467.tar.gz nixpkgs
  nix-channel --update
fi

# Build a docker image.
nix-shell -p arion --run 'arion build'
IMAGE="$(nix-shell -p arion --run 'arion config' | grep -o 'toxchat/bazel:.*')"

docker tag "$IMAGE" "toxchat/bazel:base"

mkdir layers
docker save "toxchat/bazel:base" | tar -x -C layers
