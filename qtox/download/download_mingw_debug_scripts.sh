#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

MINGW_W64_DEBUG_SCRIPTS_VERSION="c6ae689137844d1a6fd9c1b9a071d3f82a44c593"
MINGW_W64_DEBUG_SCRIPTS_HASH="5916bf9e6691d4f7f1c233c8c3a2b9f3b1d1ad0f58ab951381da5ec856f5d021"

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/nurupo/mingw-w64-debug-scripts/archive/$MINGW_W64_DEBUG_SCRIPTS_VERSION.tar.gz" \
  "$MINGW_W64_DEBUG_SCRIPTS_HASH"
