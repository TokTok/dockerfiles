#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 The TokTok team

set -euo pipefail

LIBUNWIND_VERSION=1.8.3
LIBUNWIND_HASH=be30d910e67f58d82e753231f1357f326a1a088acf126b21ff77e60aab19b90b

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/libunwind/libunwind/releases/download/v$LIBUNWIND_VERSION/libunwind-$LIBUNWIND_VERSION.tar.gz" \
  "$LIBUNWIND_HASH"
