#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euxo pipefail

# shellcheck disable=SC2016

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "sqlcipher" --supported "win32 win64 macos macos-x86_64 macos-arm64" "$@"

if [ "$LIB_TYPE" = "shared" ]; then
  ENABLE_STATIC=--disable-static
  ENABLE_SHARED=--enable-shared
else
  ENABLE_STATIC=--enable-static
  ENABLE_SHARED=--disable-shared
fi

"$SCRIPT_DIR/download/download_sqlcipher.sh"

CFLAGS="-O2 -g0 -DSQLITE_HAS_CODEC -I$DEP_PREFIX/include/ $CROSS_CFLAG"
LDFLAGS="-lcrypto -L$DEP_PREFIX/lib/ -L$DEP_PREFIX/lib64/ $CROSS_LDFLAG"

if [ "$SCRIPT_ARCH" = "win32" ] || [ "$SCRIPT_ARCH" = "win64" ]; then
  sed -i s/'if test "$TARGET_EXEEXT" = ".exe"'/'if test ".exe" = ".exe"'/g configure
  sed -i 's|exec $PWD/mksourceid manifest|exec $PWD/mksourceid.exe manifest|g' tool/mksqlite3h.tcl
  LIBS="-lgdi32 -lws2_32"
  LDFLAGS="$LDFLAGS -lgdi32"
else
  LIBS=''
fi

./configure "$HOST_OPTION" \
  --prefix="$DEP_PREFIX" \
  "$ENABLE_STATIC" \
  "$ENABLE_SHARED" \
  --disable-tcl \
  --enable-tempstore=yes \
  CFLAGS="$CFLAGS $CROSS_CFLAG" \
  LDFLAGS="$LDFLAGS $CROSS_LDFLAG" \
  LIBS="$LIBS"

if [ "$SCRIPT_ARCH" = "win32" ] || [ "$SCRIPT_ARCH" = "win64" ]; then
  sed -i s/"TEXE = $"/"TEXE = .exe"/ Makefile
fi

make -j "$MAKE_JOBS"
make install
