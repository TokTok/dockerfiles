#!/bin/bash

. set-env-android.sh
####################################################################################################

set -x

cd "$NDK_ADDON_SRC"
apt-get source gsasl

pushd gsasl*/
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
  --with-build-cc="$BUILD_GCC" \
  --enable-static \
  --disable-shared \
  --no-recursion
pushd lib
./configure \
  AS="$NDK_TOOLCHAIN"-clang \
  CC="$NDK_TOOLCHAIN"-clang \
  CXX="$NDK_TOOLCHAIN"-clang++ \
  AR=llvm-ar \
  RANLIB=llvm-ranlib \
  STRIP=llvm-strip \
  --prefix="$NDK_ADDON_PREFIX" \
  --host="$NDK_TARGET" \
  --build="$BUILD_ARCH" \
  --with-build-cc="$BUILD_GCC" \
  --enable-static \
  --disable-shared \
  --with-libgcrypt-prefix="$NDK_ADDON_PREFIX"
popd
make "$MAKEFLAGS"
make install
popd

rm -rf "${BASH_SOURCE[0]}" gsasl*
