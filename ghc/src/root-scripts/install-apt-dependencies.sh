#!/bin/sh

set -eux

export DEBIAN_FRONTEND="noninteractive"

apt-get update
apt-get -y --no-install-recommends install \
  autoconf \
  automake \
  autopoint \
  build-essential \
  c2hs \
  cabal-install \
  ca-certificates \
  curl \
  ghc \
  git \
  gtk-doc-tools \
  libtool \
  llvm-11 \
  p7zip-full \
  pkg-config \
  python3 \
  texinfo \
  unzip \
  wget \
  zlib1g-dev
apt-get clean

# We specifically don't delete the sources here because we need them for
# "apt-get source" later in the build.
