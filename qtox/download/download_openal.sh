#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

OPENAL_VERSION=1.25.2
OPENAL_HASH=fb27e5839aa11f0e5b9d33756965291fad5d6909ab928ea1f796f4a1a6877894

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/kcat/openal-soft/archive/refs/tags/$OPENAL_VERSION.tar.gz" \
  "$OPENAL_HASH"
