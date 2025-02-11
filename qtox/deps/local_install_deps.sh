#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2022 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

ARCH="$(uname -m)"
BUILD_TYPE="release"
SANITIZE=""
MACOS_VERSION="12.0"

GIT_ROOT="$(git rev-parse --show-toplevel)"
DEP_PREFIX="$GIT_ROOT/third_party/deps"

usage() {
  echo "Usage: $0 --project-name <project-name> [options]"
  echo "Options:"
  echo "  --arch <arch>                   Architecture (arm64 or x86_64)"
  echo "  --build-type <build-type>       Build type (debug or release)"
  echo "  --dep-file <depfile>            Dependency file (required)"
  echo "  --dep-prefix <dep-prefix>       Dependency prefix (default: third_party/deps)"
  echo "  --sanitize <sanitize>           Sanitizer (address, thread, undefined)"
  echo "  --macos-version <macos-version> macOS version (default: 12.0)"
  echo "  --help, -h                      Show this help message"
}

while (($# > 0)); do
  case $1 in
    --arch)
      ARCH=$2
      shift 2
      ;;
    --build-type)
      BUILD_TYPE=$2
      shift 2
      ;;
    --dep-file)
      DEP_FILE=$2
      shift 2
      ;;
    --dep-prefix)
      DEP_PREFIX=$2
      shift 2
      ;;
    --sanitize)
      SANITIZE=$2
      shift 2
      ;;
    --macos-version)
      MACOS_VERSION=$2
      shift 2
      ;;
    --help | -h)
      usage
      exit 1
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Unexpected argument $1"
      usage
      exit 1
      ;;
  esac
done

case "$(uname -s)" in
  Darwin)
    SYSTEM="macos"
    ;;
  Linux)
    SYSTEM="linux"
    ;;
  *)
    echo "Unsupported system: $(uname -s)"
    exit 1
    ;;
esac

install_deps() {
  DOCKERFILES="$PWD"
  for dep in "$@"; do
    mkdir -p "external/$dep"
    pushd "external/$dep"
    if [ -f "$DOCKERFILES/qtox/build_${dep}_$SYSTEM.sh" ]; then
      SCRIPT="$DOCKERFILES/qtox/build_${dep}_$SYSTEM.sh"
    else
      SCRIPT="$DOCKERFILES/qtox/build_$dep.sh"
    fi
    "$SCRIPT" \
      --arch "$SYSTEM-$ARCH" \
      --libtype "static" \
      --buildtype "$BUILD_TYPE" \
      --sanitize "$SANITIZE" \
      --prefix "$DEP_PREFIX" \
      --macos "$MACOS_VERSION"
    popd
    rm -rf "external/$dep"
  done
  rmdir external
}

# Read deps from depfile, ignoring lines with "#" and empty lines
DEPS=()
while IFS= read -r line; do
  if [ -n "$line" ] && [ "${line:0:1}" != "#" ]; then
    DEPS+=("$line")
  fi
done <"$DEP_FILE"

install_deps "${DEPS[@]}"
