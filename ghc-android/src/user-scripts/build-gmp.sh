#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

echo Downloading gmp $GMP_RELEASE
curl -o "${TARDIR}/${GMP_TAR_FILE}"  https://gmplib.org/download/gmp/${GMP_TAR_FILE} 2>&1
check_md5 "$GMP_TAR_PATH" "$GMP_MD5"

pushd $NDK_ADDON_SRC
tar xf "$TARDIR/$GMP_TAR_FILE"
popd

pushd $GMP_SRC
./configure --prefix="$NDK_ADDON_PREFIX" --host=$NDK_TARGET --build=$BUILD_ARCH --with-build-cc=$BUILD_GCC --enable-static --disable-shared
make $MAKEFLAGS
make install
popd

rm -rf ${BASH_SOURCE[0]} $GMP_SRC "$TARDIR/$GMP_TAR_FILE"
