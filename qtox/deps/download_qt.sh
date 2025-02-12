#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team

set -euxo pipefail

ARCH="arm64"
DEP_PREFIX="third_party/deps"
MACOS_VERSION="12.0"

usage() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  --arch <arch>                   Architecture (arm64 or x86_64)"
  echo "  --dep-prefix <dep-prefix>       Dependency prefix (default: third_party/deps)"
  echo "  --macos-version <macos-version> macOS version (default: 12.0)"
  echo "  --help, -h                      Show this help message"
}

while (($# > 0)); do
  case $1 in
    --arch)
      ARCH=$2
      shift 2
      ;;
    --dep-prefix)
      DEP_PREFIX=$2
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
    *)
      echo "Unexpected argument $1"
      usage
      exit 1
      ;;
  esac
done

mkdir -p "$DEP_PREFIX"
tar -zxf <(curl -L "https://github.com/TokTok/dockerfiles/releases/download/nightly/qt-static-macos-$ARCH-$MACOS_VERSION.tar.gz") -C "$DEP_PREFIX"
