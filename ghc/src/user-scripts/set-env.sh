#!/bin/bash
# shellcheck disable=SC2034

#
# This script is responsible for setting up all the environment variables
# exactly the way they should be for building GHC. It will be sourced from other
# build scripts, but not run directly by Docker.
#

set -eu

if [ -e /etc/makepkg.conf ]; then
  source /etc/makepkg.conf
fi
MAKEFLAGS=${MAKEFLAGS:--j$(nproc)}

# Basic configuration
GHCHOME=$HOME/.ghc
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$BASEDIR"

HOST_BUILD_DIR="$BASEDIR/build-host"

GHC_STAGE0_SRC="$BASEDIR/stage0"
GHC_STAGE0_PREFIX="$GHCHOME/android-host"
GHC_STAGE0="$GHC_STAGE0_PREFIX/bin/ghc"

# GHC tarball
GHC_RELEASE=8.6.5
GHC_MD5=b47726aaf302eb87b4970fcee924d45d

CONFIG_SUB_SRC=${CONFIG_SUB_SRC:-/usr/share/automake-1.16}

BUILD_GCC=gcc
BUILD_ARCH=$("$BUILD_GCC" -v 2>&1 | grep ^Target: | cut -f 2 -d ' ')

mkdir -p "$GHCHOME"
mkdir -p "$HOST_BUILD_DIR"
mkdir -p "$BASEDIR/tarfiles"
TARDIR="$BASEDIR/tarfiles"

function check_md5() {
  FILENAME="$1"
  MD5="$2"
  [ -e "$FILENAME" ] || return 1
  ACTUAL_MD5=$(md5sum "$FILENAME" | cut -f1 -d ' ')
  if [ ! "$ACTUAL_MD5" == "$MD5" ]; then
    echo >&2 "MD5 hash of $FILENAME did not match."
    echo >&2 "$MD5 =/= $ACTUAL_MD5"
    exit 1
  fi
}

function apply_patches() {
  pushd "$2" >/dev/null
  readarray -t PATCHES<<<"$(find "$BASEDIR/patches" -name "$1")"
  for p in "${PATCHES[@]}"; do
    echo Applying patch "$p" in "$PWD"
    patch -p1 <"$p"
  done
  popd >/dev/null
}

GHC_TAR_FILE=ghc-$GHC_RELEASE-src.tar.xz
GHC_TAR_PATH="$TARDIR/$GHC_TAR_FILE"

if ! [ -e "$CONFIG_SUB_SRC/config.sub" ]; then
  CONFIG_SUB_SRC=${CONFIG_SUB_SRC:-$NCURSES_SRC}
fi

echo "Current build dir size:"
du -sh "$BASE"
