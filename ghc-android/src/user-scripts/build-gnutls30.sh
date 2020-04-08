#!/bin/bash

. set-env-android.sh
####################################################################################################

cd $NDK_ADDON_SRC
apt-get source gnutls28

pushd gnutls28*/
patch -p1 < $BASEDIR/patches/gnutls-no-atfork.patch
export PKG_CONFIG_PATH="$NDK_ADDON_PREFIX/lib/pkgconfig"
autoreconf -fi
./configure \
  --disable-tests \
  --disable-doc \
  --disable-guile \
  --with-included-libtasn1 \
  --with-included-unistring \
  --without-p11-kit \
  --prefix="$NDK_ADDON_PREFIX" \
  --host="$NDK_TARGET" \
  --build="$BUILD_ARCH" \
  --enable-static \
  --disable-shared
pushd gl
make $MAKEFLAGS
popd
pushd lib
make $MAKEFLAGS
make install
popd
popd

rm -rf ${BASH_SOURCE[0]} gnutls28*
