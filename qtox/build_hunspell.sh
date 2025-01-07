#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "hunspell" --supported "linux-x86_64 win32 win64 macos-x86_64 macos-arm64 win32 win64" "$@"

if [ "$LIB_TYPE" = "shared" ]; then
  ENABLE_STATIC=--disable-static
  ENABLE_SHARED=--enable-shared
else
  ENABLE_STATIC=--enable-static
  ENABLE_SHARED=--disable-shared
fi

"$SCRIPT_DIR/download/download_hunspell.sh"

./configure "$HOST_OPTION" \
  --prefix="$DEP_PREFIX" \
  "$ENABLE_STATIC" \
  "$ENABLE_SHARED" \
  LDFLAGS="-fstack-protector $CROSS_LDFLAG" \
  CXXFLAGS="-O2 -g0 $CROSS_CFLAG" \
  CFLAGS="-O2 -g0 $CROSS_CFLAG"

make -j "$MAKE_JOBS"
make install
