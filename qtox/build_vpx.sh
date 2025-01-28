#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "vpx" --supported "linux-aarch64 linux-x86_64 win32 win64 macos-x86_64 macos-arm64 ios-arm64 ios-armv7 ios-armv7s iphonesimulator-arm64 iphonesimulator-x86_64" "$@"

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
elif [ "$SCRIPT_ARCH" == "macos-arm64" ]; then
  ARCH_FLAGS=""
  CROSS_ARG=""
  TARGET_ARG="arm64-darwin20-gcc" # macOS 11.0
elif [ "$SCRIPT_ARCH" == "macos-x86_64" ]; then
  ARCH_FLAGS=""
  CROSS_ARG=""
  TARGET_ARG="x86_64-darwin19-gcc" # macOS 10.15
elif [ "$SCRIPT_ARCH" == "ios-arm64" ]; then
  ARCH_FLAGS=""
  CROSS_ARG=""
  TARGET_ARG="arm64-darwin-gcc"
elif [ "$SCRIPT_ARCH" == "ios-armv7" ]; then
  ARCH_FLAGS=""
  CROSS_ARG=""
  TARGET_ARG="armv7-darwin-gcc"
elif [ "$SCRIPT_ARCH" == "ios-armv7s" ]; then
  ARCH_FLAGS=""
  CROSS_ARG=""
  TARGET_ARG="armv7s-darwin-gcc"
elif [ "$SCRIPT_ARCH" == "iphonesimulator-arm64" ]; then
  ARCH_FLAGS=""
  CROSS_ARG=""
  TARGET_ARG="arm64-iphonesimulator-gcc"
elif [ "$SCRIPT_ARCH" == "iphonesimulator-x86_64" ]; then
  ARCH_FLAGS=""
  CROSS_ARG=""
  TARGET_ARG="x86_64-iphonesimulator-gcc"
elif [ "$SCRIPT_ARCH" == "linux-x86_64" ]; then
  ARCH_FLAGS=""
  CROSS_ARG=""
  TARGET_ARG="x86_64-linux-gcc"
elif [ "$SCRIPT_ARCH" == "linux-aarch64" ]; then
  ARCH_FLAGS=""
  CROSS_ARG=""
  TARGET_ARG="arm64-linux-gcc"
else
  echo "Unsupported arch: $SCRIPT_ARCH"
  exit 1
fi

if [ "$LIB_TYPE" = "shared" ] && [ "$SCRIPT_ARCH" != "win32" ] && [ "$SCRIPT_ARCH" != "win64" ]; then
  ENABLE_STATIC=--disable-static
  ENABLE_SHARED=--enable-shared
else
  ENABLE_STATIC=--enable-static
  ENABLE_SHARED=--disable-shared
fi

"$SCRIPT_DIR/download/download_vpx.sh"

patch -p1 <"$SCRIPT_DIR/patches/vpx.patch"
CFLAGS="-O2 $ARCH_FLAGS $CROSS_CFLAG" \
  CXXFLAGS="-O2 $CROSS_CXXFLAG" \
  LDFLAGS="$CROSS_LDFLAG" \
  CROSS="$CROSS_ARG" \
  ./configure \
  --target="$TARGET_ARG" \
  --prefix="$DEP_PREFIX" \
  "$ENABLE_STATIC" \
  "$ENABLE_SHARED" \
  --enable-runtime-cpu-detect \
  --disable-examples \
  --disable-tools \
  --disable-docs \
  --disable-unit-tests \
  --enable-pic

make -j "$MAKE_JOBS"
make install
