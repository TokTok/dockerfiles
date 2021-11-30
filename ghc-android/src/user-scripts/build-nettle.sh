#!/bin/bash

. set-env-android.sh
####################################################################################################

cd "$NDK_ADDON_SRC"

apt-get source nettle

pushd nettle*/
autoreconf -fi
./configure \
  AS="$NDK_TOOLCHAIN-clang" \
  CC="$NDK_TOOLCHAIN-clang" \
  CXX="$NDK_TOOLCHAIN-clang++" \
  AR=llvm-ar \
  RANLIB=llvm-ranlib \
  STRIP=llvm-strip \
  --prefix="$NDK_ADDON_PREFIX" \
  --host="$NDK_TARGET" \
  --build="$BUILD_ARCH" \
  --enable-static \
  --disable-shared \
  CFLAGS="$CFLAGS -std=gnu99"
make "$MAKEFLAGS"
make install
popd

rm -rf "${BASH_SOURCE[0]}" nettle*
