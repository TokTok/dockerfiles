#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

# https://github.com/KDE/kimageformats/tags
# macOS 10.15 builds use Qt 6.6, too old for newer KDE Frameworks.
if [ "$MACOS_MINIMUM_SUPPORTED_VERSION" = "10.15" ]; then
  KIMAGEFORMATS_VERSION=6.9.0
  KIMAGEFORMATS_HASH=5db2860ddcdf430a875815509d914a3243a82d2c06aa06436ef6725d309da8f7
else
  KIMAGEFORMATS_VERSION=6.31.0
  KIMAGEFORMATS_HASH=e680111b71db669b782464fb3a273e49836a9363c0932be32724172e43707461
fi

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/KDE/kimageformats/archive/refs/tags/v$KIMAGEFORMATS_VERSION.tar.gz" \
  "$KIMAGEFORMATS_HASH"
