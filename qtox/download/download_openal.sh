#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

if [ "$1" = "patched" ]; then
  OPENAL_VERSION=b80570bed017de60b67c6452264c634085c3b148
  OPENAL_HASH=e9f6d37672e085d440ef8baeebb7d62fec1d152094c162e5edb33b191462bd78

  source "$(dirname "$(realpath "$0")")/common.sh"

  ## We can stop using the fork once OpenAL-Soft gets loopback capture implemented:
  ## https://github.com/kcat/openal-soft/pull/421
  download_verify_extract_tarball \
    "https://github.com/irungentoo/openal-soft-tox/archive/$OPENAL_VERSION.tar.gz" \
    "$OPENAL_HASH"
else
  OPENAL_VERSION=1.25.2
  OPENAL_HASH=fb27e5839aa11f0e5b9d33756965291fad5d6909ab928ea1f796f4a1a6877894

  source "$(dirname "$(realpath "$0")")/common.sh"

  download_verify_extract_tarball \
    "https://github.com/kcat/openal-soft/archive/refs/tags/$OPENAL_VERSION.tar.gz" \
    "$OPENAL_HASH"
fi
