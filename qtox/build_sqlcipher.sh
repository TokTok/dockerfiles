#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
#     Copyright (c) 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
#     Copyright (c) 2021 by The qTox Project Contributors

# shellcheck disable=SC2016

set -euo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "sqlcipher" --supported "win32 win64 macos macos-x86_64 macos-arm64" "$@"

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
  --enable-static \
  --disable-shared \
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
