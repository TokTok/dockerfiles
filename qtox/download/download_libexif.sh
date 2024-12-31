#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euo pipefail

# https://github.com/libexif/libexif/releases
LIBEXIF_VERSION=0.6.24
LIBEXIF_HASH=d47564c433b733d83b6704c70477e0a4067811d184ec565258ac563d8223f6ae

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
  "https://github.com/libexif/libexif/releases/download/v$LIBEXIF_VERSION/libexif-$LIBEXIF_VERSION.tar.bz2" \
  "$LIBEXIF_HASH"
