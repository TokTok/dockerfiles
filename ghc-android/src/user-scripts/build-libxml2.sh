#!/bin/bash

. set-env-android.sh
####################################################################################################

cd "$NDK_ADDON_SRC"
apt-get source libxml2

pushd libxml2*/
patch -p0 <"$BASEDIR"/patches/libxml2-no-tests.patch
autoreconf -fi
./configure \
  --prefix="$NDK_ADDON_PREFIX" \
  --host="$NDK_TARGET" \
  --build="$BUILD_ARCH" \
  --with-build-cc="$BUILD_GCC" \
  --enable-static \
  --disable-shared \
  --without-python
make "$MAKEFLAGS"
make install
popd

rm -rf "${BASH_SOURCE[0]}" libxml2*
