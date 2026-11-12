#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

SONNET_VERSION=6.31.0
SONNET_HASH=b0fb88a08d281bb1c426229259b84959acb4503e8260103d5bcacbccb93c10e3

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/KDE/sonnet/archive/refs/tags/v$SONNET_VERSION.tar.gz" \
  "$SONNET_HASH"
