#!/bin/bash

. set-env-android.sh
####################################################################################################

cd "$NDK_ADDON_SRC"
apt-get source libgnutls30

apply_patches 'gnutls.patch' gnutls28*/

pushd gnutls28*/
sed -i -e 's/^\(bin\|noinst\)_PROGRAMS/#&/' src/Makefile.am
export PKG_CONFIG_PATH="$NDK_ADDON_PREFIX/lib/pkgconfig"
autoreconf -fi
./configure \
  AS="$NDK_TOOLCHAIN-clang" \
  CC="$NDK_TOOLCHAIN-clang" \
  CXX="$NDK_TOOLCHAIN-clang++" \
  AR=llvm-ar \
  RANLIB=llvm-ranlib \
  STRIP=llvm-strip \
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
  --disable-shared \
  CFLAGS="$CFLAGS -fgnu89-inline"
pushd gl
make "$MAKEFLAGS"
popd
pushd lib
make "$MAKEFLAGS"
make install
popd
popd

rm -rf "${BASH_SOURCE[0]}" gnutls28*
