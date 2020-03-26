#!/bin/bash

. set-env.sh
####################################################################################################

cd $NDK_ADDON_SRC
apt-get source gsasl

pushd gsasl*/
patch -p1 < $BASEDIR/patches/gsasl-avoid-memxor-conflict.patch
sed -i -e 's/^dist_man_MANS/#&/' doc/Makefile.am
autoreconf -fi
./configure \
  --prefix="$NDK_ADDON_PREFIX" \
  --host="$NDK_TARGET" \
  --build="$BUILD_ARCH" \
  --with-build-cc="$BUILD_GCC" \
  --enable-static \
  --disable-shared
make $MAKEFLAGS
make install
popd

rm -rf ${BASH_SOURCE[0]} gsasl*
