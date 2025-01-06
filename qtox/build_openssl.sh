#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "openssl" --supported "linux-x86_64 win32 win64 macos-x86_64 macos-arm64" "$@"

if [ "$SCRIPT_ARCH" == "win64" ]; then
  OPENSSL_ARCH="mingw64"
  CROSS_COMPILE_ARCH="--cross-compile-prefix=$MINGW_ARCH-w64-mingw32-"
elif [ "$SCRIPT_ARCH" == "win32" ]; then
  OPENSSL_ARCH="mingw"
  CROSS_COMPILE_ARCH="--cross-compile-prefix=$MINGW_ARCH-w64-mingw32-"
elif [ "$SCRIPT_ARCH" == "macos-x86_64" ]; then
  OPENSSL_ARCH="darwin64-x86_64-cc"
  CROSS_COMPILE_ARCH=""
elif [ "$SCRIPT_ARCH" == "macos-arm64" ]; then
  OPENSSL_ARCH="darwin64-arm64-cc"
  CROSS_COMPILE_ARCH=""
elif [ "$SCRIPT_ARCH" == "linux-x86_64" ]; then
  OPENSSL_ARCH="linux-x86_64"
  CROSS_COMPILE_ARCH=""
else
  echo "Unsupported arch: $SCRIPT_ARCH"
  exit 1
fi

if [ "$LIB_TYPE" = "static" ]; then
  ENABLE_SHARED="-no-shared"
else
  ENABLE_SHARED="shared"
fi

"$SCRIPT_DIR/download/download_openssl.sh"

CFLAGS="-O2 $CROSS_CFLAG" \
  LDFLAGS="$CROSS_LDFLAG" \
  ./Configure \
  --prefix="$DEP_PREFIX" \
  --openssldir="$DEP_PREFIX/ssl" \
  "$ENABLE_SHARED" \
  -no-tests -fPIC \
  "$CROSS_COMPILE_ARCH" \
  "$OPENSSL_ARCH"

make -j "$MAKE_JOBS"
make install_sw
