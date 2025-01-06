#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

# https://www.ffmpeg.org/releases
FFMPEG_VERSION=7.1
FFMPEG_HASH=40973d44970dbc83ef302b0609f2e74982be2d85916dd2ee7472d30678a7abe6

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://www.ffmpeg.org/releases/ffmpeg-$FFMPEG_VERSION.tar.xz" \
  "$FFMPEG_HASH"
