#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

# https://github.com/KDE/kimageformats/tags
KIMAGEFORMATS_VERSION=6.31.0
KIMAGEFORMATS_HASH=e680111b71db669b782464fb3a273e49836a9363c0932be32724172e43707461

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/KDE/kimageformats/archive/refs/tags/v$KIMAGEFORMATS_VERSION.tar.gz" \
  "$KIMAGEFORMATS_HASH"
