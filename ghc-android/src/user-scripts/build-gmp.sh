#!/bin/bash

. set-env-android.sh
####################################################################################################

echo Downloading gmp "$GMP_RELEASE"
curl -o "$TARDIR/$GMP_TAR_FILE" https://gmplib.org/download/gmp/"$GMP_TAR_FILE" 2>&1
check_md5 "$GMP_TAR_PATH" "$GMP_MD5"

pushd "$NDK_ADDON_SRC"
tar xf "$TARDIR/$GMP_TAR_FILE"
popd

pushd "$GMP_SRC"
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
  --with-pic \
  CFLAGS="$CFLAGS -fPIC"
make "$MAKEFLAGS"
make install
popd

rm -rf "${BASH_SOURCE[0]}" "$GMP_SRC" "${TARDIR:?}/$GMP_TAR_FILE"
