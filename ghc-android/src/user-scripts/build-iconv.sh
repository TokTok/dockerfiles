#!/bin/bash

. set-env-android.sh
####################################################################################################

git clone https://github.com/ironsteel/iconv-android.git "$ICONV_SRC" 2>&1
pushd "$ICONV_SRC"
git checkout "$ICONV_GIT_COMMIT" 2>&1
popd

# Update config.sub and config.guess
cp "$CONFIG_SUB_SRC/config.sub" "$ICONV_SRC/build-aux"
cp "$CONFIG_SUB_SRC/config.guess" "$ICONV_SRC/build-aux"
cp "$CONFIG_SUB_SRC/config.sub" "$ICONV_SRC/libcharset/build-aux"
cp "$CONFIG_SUB_SRC/config.guess" "$ICONV_SRC/libcharset/build-aux"

apply_patches 'iconv-*' "$ICONV_SRC"

set -x

pushd "$ICONV_SRC"
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
  --disable-shared || (cat config.log && false)
make "$MAKEFLAGS"
make install
popd

rm -rf "${BASH_SOURCE[0]}" "$ICONV_SRC"
