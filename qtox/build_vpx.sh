#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
#     Copyright (c) 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
#     Copyright (c) 2021 by The qTox Project Contributors

set -euo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "vpx" --supported "win32 win64 macos macos-x86_64 macos-arm64" "$@"

if [ "$SCRIPT_ARCH" == "win64" ]; then
  # There is a bug in gcc that breaks avx512 on 64-bit Windows https://gcc.gnu.org/bugzilla/show_bug.cgi?id=54412
  # VPX fails to build due to it.
  # This is a workaround as suggested in https://stackoverflow.com/questions/43152633
  ARCH_FLAGS="-fno-asynchronous-unwind-tables"
  CROSS_ARG="$MINGW_ARCH-w64-mingw32-"
  TARGET_ARG="x86_64-win64-gcc"
elif [ "$SCRIPT_ARCH" == "win32" ]; then
  ARCH_FLAGS=""
  CROSS_ARG="$MINGW_ARCH-w64-mingw32-"
  TARGET_ARG="x86-win32-gcc"
elif [ "$SCRIPT_ARCH" == "macos" ] || [ "$SCRIPT_ARCH" == "macos-x86_64" ]; then
  ARCH_FLAGS=""
  CROSS_ARG=""
  TARGET_ARG="x86_64-darwin22-gcc" # macOS 13
elif [ "$SCRIPT_ARCH" == "macos-arm64" ]; then
  ARCH_FLAGS=""
  CROSS_ARG=""
  TARGET_ARG="arm64-darwin23-gcc" # macOS 14
else
  exit 1
fi

"$SCRIPT_DIR/download/download_vpx.sh"

if [ "$SCRIPT_ARCH" == "win32" ] || [ "$SCRIPT_ARCH" == "win64" ] || [ "$SCRIPT_ARCH" == "macos-x86_64" ] || [ "$SCRIPT_ARCH" == "macos-arm64" ]; then
  ENABLE_STATIC="--enable-static"
  ENABLE_SHARED="--disable-shared"
else
  ENABLE_STATIC="--disable-static"
  ENABLE_SHARED="--enable-shared"
fi

CFLAGS="$ARCH_FLAGS $CROSS_CFLAG" \
  CPPFLAGS="$CROSS_CPPFLAG" \
  LDFLAGS="$CROSS_LDFLAG" \
  CROSS="$CROSS_ARG" \
  ./configure \
  "--target=$TARGET_ARG" \
  "--prefix=$DEP_PREFIX" \
  "$ENABLE_STATIC" \
  "$ENABLE_SHARED" \
  --enable-runtime-cpu-detect \
  --disable-examples \
  --disable-tools \
  --disable-docs \
  --disable-unit-tests

make -j "$MAKE_JOBS"
make install

if [ "$SCRIPT_ARCH" == "macos" ]; then
  install_name_tool -id '@rpath/libvpx.dylib' "$DEP_PREFIX"/lib/libvpx.dylib
fi
