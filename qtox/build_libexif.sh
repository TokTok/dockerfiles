#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
#     Copyright (c) 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
#     Copyright (c) 2021 by The qTox Project Contributors

set -euo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "libexif" --supported "win32 win64 macos macos-x86_64 macos-arm64" "$@"

if [ "$LIB_TYPE" = "shared" ]; then
  ENABLE_STATIC=--disable-static
  ENABLE_SHARED=--enable-shared
else
  ENABLE_STATIC=--enable-static
  ENABLE_SHARED=--disable-shared
fi

"$SCRIPT_DIR/download/download_libexif.sh"

CFLAGS="-O2 -g0 $CROSS_CFLAG" \
  LDFLAGS="$CROSS_LDFLAG" \
  ./configure "$HOST_OPTION" \
  "--prefix=$DEP_PREFIX" \
  "$ENABLE_STATIC" \
  "$ENABLE_SHARED" \
  --disable-docs \
  --disable-nls

make -j "$MAKE_JOBS"
make install
