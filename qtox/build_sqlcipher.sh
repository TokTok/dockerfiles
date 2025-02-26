#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

# shellcheck disable=SC2016

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "sqlcipher" --supported "linux-x86_64 win32 win64 macos-x86_64 macos-arm64 wasm" "$@"

"$SCRIPT_DIR/download/download_sqlcipher.sh"

CONFIGURE_FLAGS=()
if [ "$LIB_TYPE" = "shared" ]; then
  CONFIGURE_FLAGS+=(--disable-static --enable-shared)
else
  CONFIGURE_FLAGS+=(--enable-static --disable-shared)
fi

CFLAGS="-O2 -g0 -DSQLITE_HAS_CODEC -I$DEP_PREFIX/include/ $CROSS_CFLAG"

if [ "$SCRIPT_ARCH" = "wasm" ]; then
  CONFIGURE_FLAGS+=(--with-crypto-lib=libtomcrypt)
  CONFIGURE_FLAGS+=(BUILD_CC="cc" CC=/opt/buildhome/emsdk/upstream/emscripten/emcc)
  LDFLAGS="-L$DEP_PREFIX/lib/ -L$DEP_PREFIX/lib64/ -L$DEP_PREFIX/libx32/"
else
  LDFLAGS="-lcrypto -L$DEP_PREFIX/lib/ -L$DEP_PREFIX/lib64/ -L$DEP_PREFIX/libx32/"
fi

if [ "$SCRIPT_ARCH" = "win32" ] || [ "$SCRIPT_ARCH" = "win64" ]; then
  sed -i s/'if test "$TARGET_EXEEXT" = ".exe"'/'if test ".exe" = ".exe"'/g configure
  sed -i 's|exec $PWD/mksourceid manifest|exec $PWD/mksourceid.exe manifest|g' tool/mksqlite3h.tcl
  LIBS="-lgdi32 -lws2_32"
  LDFLAGS="$LDFLAGS -lgdi32"
else
  LIBS=''
fi

./configure "${HOST_OPTION[@]}" \
  --prefix="$DEP_PREFIX" \
  "${CONFIGURE_FLAGS[@]}" \
  --disable-tcl \
  --enable-tempstore=yes \
  CFLAGS="$CFLAGS $CROSS_CFLAG" \
  LDFLAGS="$LDFLAGS $CROSS_LDFLAG" \
  LIBS="$LIBS" ||
  (cat config.log && exit 1)

if [ "$SCRIPT_ARCH" = "win32" ] || [ "$SCRIPT_ARCH" = "win64" ]; then
  sed -i s/"TEXE = $"/"TEXE = .exe"/ Makefile
fi

make -j "$MAKE_JOBS"
make install
