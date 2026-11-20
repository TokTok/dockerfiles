#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

# https://invent.kde.org/frameworks/extra-cmake-modules/-/tags
# macOS 10.15 builds use Qt 6.6, too old for newer KDE Frameworks.
if [ "$MACOS_MINIMUM_SUPPORTED_VERSION" = "10.15" ]; then
  EXTRA_CMAKE_MODULES_VERSION=6.9.0
  EXTRA_CMAKE_MODULES_HASH=8cc970b26486732b757bc92e7146021fba47de530ed0bc9ec4955b33e9e345d2
else
  EXTRA_CMAKE_MODULES_VERSION=6.31.0
  EXTRA_CMAKE_MODULES_HASH=a27ff118cb96af3bacffb289f52e56af3eaa1d73b01f5ca794aa29b760f0204e
fi

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://invent.kde.org/frameworks/extra-cmake-modules/-/archive/v$EXTRA_CMAKE_MODULES_VERSION/extra-cmake-modules-v$EXTRA_CMAKE_MODULES_VERSION.tar.gz" \
  "$EXTRA_CMAKE_MODULES_HASH"
