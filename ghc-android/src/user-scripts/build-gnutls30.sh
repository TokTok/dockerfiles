#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

cd $NDK_ADDON_SRC
apt-get source libgnutls30

pushd gnutls28*
patch -p1 < $BASEDIR/patches/gnutls-no-atfork.patch
export PKG_CONFIG_PATH="$NDK_ADDON_PREFIX/lib/pkgconfig"
./configure --disable-tests --disable-doc --disable-guile --with-included-libtasn1 --without-p11-kit --prefix="$NDK_ADDON_PREFIX" --host=$NDK_TARGET --build=$BUILD_ARCH CC="$NDK_TARGET-gcc -fgnu89-inline" --enable-static --disable-shared
pushd gl
make $MAKEFLAGS
popd
pushd lib
make $MAKEFLAGS
make install
popd
popd

rm -rf ${BASH_SOURCE[0]} gnutls28*
