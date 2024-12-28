#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024 The TokTok team

set -euo pipefail

ZSTD_VERSION=1.5.6
ZSTD_HASH=8c29e06cf42aacc1eafc4077ae2ec6c6fcb96a626157e0593d5e82a34fd403c1

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/facebook/zstd/releases/download/v$ZSTD_VERSION/zstd-$ZSTD_VERSION.tar.gz" \
  "$ZSTD_HASH"
