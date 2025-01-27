#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "opus" --supported "linux-aarch64 linux-x86_64 win32 win64 macos-x86_64 macos-arm64 ios-arm64 ios-armv7 ios-armv7s ios-i386 ios-x86_64" "$@"

if [ "$LIB_TYPE" = "shared" ]; then
  ENABLE_STATIC=--disable-static
  ENABLE_SHARED=--enable-shared
else
  ENABLE_STATIC=--enable-static
  ENABLE_SHARED=--disable-shared
fi

"$SCRIPT_DIR/download/download_opus.sh"

LDFLAGS="-fstack-protector $CROSS_LDFLAG" \
  CFLAGS="-O2 -fPIC -g0 $CROSS_CFLAG" \
  ./configure "$HOST_OPTION" \
  "--prefix=$DEP_PREFIX" \
  "$ENABLE_STATIC" \
  "$ENABLE_SHARED" \
  --disable-extra-programs \
  --disable-doc

make -j "$MAKE_JOBS"
make install
