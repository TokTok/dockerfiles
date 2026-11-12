#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

# https://www.ffmpeg.org/releases
FFMPEG_VERSION=9.0.2
FFMPEG_HASH=8c3850283eb25fa026482078a04051e0be17347b09ef81a0849bec15a96e002e

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://www.ffmpeg.org/releases/ffmpeg-$FFMPEG_VERSION.tar.xz" \
  "$FFMPEG_HASH"
