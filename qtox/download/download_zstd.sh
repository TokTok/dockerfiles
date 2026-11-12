#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

ZSTD_VERSION=1.5.7
ZSTD_HASH=eb33e51f49a15e023950cd7825ca74a4a2b43db8354825ac24fc1b7ee09e6fa3

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/facebook/zstd/releases/download/v$ZSTD_VERSION/zstd-$ZSTD_VERSION.tar.gz" \
  "$ZSTD_HASH"
