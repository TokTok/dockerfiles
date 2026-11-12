#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

# https://github.com/libexpat/libexpat/releases
EXPAT_VERSION="2.10.0"
EXPAT_HASH="c624ba2998fc65df1163a49641ff3f9ab73138b11641d92c86bee0fb01b1bc7f"

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/libexpat/libexpat/releases/download/R_${EXPAT_VERSION//./_}/expat-$EXPAT_VERSION.tar.xz" \
  "$EXPAT_HASH"
