#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

git clone https://github.com/ironsteel/iconv-android.git $ICONV_SRC 2>&1
pushd $ICONV_SRC
git checkout $ICONV_GIT_COMMIT 2>&1
popd

# Update config.sub and config.guess
cp "$CONFIG_SUB_SRC/config.sub" "$ICONV_SRC/build-aux"
cp "$CONFIG_SUB_SRC/config.guess" "$ICONV_SRC/build-aux"
cp "$CONFIG_SUB_SRC/config.sub" "$ICONV_SRC/libcharset/build-aux"
cp "$CONFIG_SUB_SRC/config.guess" "$ICONV_SRC/libcharset/build-aux"

apply_patches 'iconv-*' $ICONV_SRC

pushd $ICONV_SRC
./configure --prefix="$NDK_ADDON_PREFIX" --host=$NDK_TARGET --build=$BUILD_ARCH \
  --with-build-cc=$BUILD_GCC --enable-static --disable-shared
make $MAKEFLAGS
make install
popd

rm -rf ${BASH_SOURCE[0]} $ICONV_SRC
