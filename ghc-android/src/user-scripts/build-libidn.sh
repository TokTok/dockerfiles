#!/bin/bash

. set-env-android.sh
####################################################################################################

cd "$NDK_ADDON_SRC"
apt-get source libidn

pushd libidn*/
sed -i -e 's/^dist_man_MANS/#&/' doc/Makefile.am
autoreconf -fi
./configure \
  --prefix="$NDK_ADDON_PREFIX" \
  --host="$NDK_TARGET" \
  --build="$BUILD_ARCH" \
  --with-build-cc="$BUILD_GCC" \
  --enable-static \
  --disable-shared \
  --disable-gtk-doc-html
make "$MAKEFLAGS" || true
make install
popd

rm -rf "${BASH_SOURCE[0]}" libidn*
