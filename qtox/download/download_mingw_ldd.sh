#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

MINGW_LDD_VERSION=0.2.1
MINGW_LDD_HASH=60d34506d2f345e011b88de172ef312f37ca3ba87f3764f511061b69878ab204

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/nurupo/mingw-ldd/archive/v$MINGW_LDD_VERSION.tar.gz" \
  "$MINGW_LDD_HASH"
