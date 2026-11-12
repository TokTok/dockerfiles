#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euo pipefail

# https://github.com/libexif/libexif/releases
LIBEXIF_VERSION=0.6.26
LIBEXIF_HASH=0830ed253fceeb60444fb309598bc8a9491d3007dc054aad3a50a347c5597c57

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/libexif/libexif/releases/download/v$LIBEXIF_VERSION/libexif-$LIBEXIF_VERSION.tar.bz2" \
  "$LIBEXIF_HASH"
