#!/bin/bash

. set-env-android.sh
####################################################################################################

cd $NDK_ADDON_SRC

apt-get source nettle
# curl 'https://ftp.gnu.org/gnu/nettle/nettle-3.3.tar.gz' --output nettlXe.tar.gz
# tar -xzvf nettlXe.tar.gz

pushd nettle*/
sed -i -e 's/__gmpz_mpz_powm/__gmpz_powm/' configure.ac
autoreconf -fi
./configure \
  --prefix="$NDK_ADDON_PREFIX" \
  --host="$NDK_TARGET" \
  --build="$BUILD_ARCH" \
  --with-build-cc="$BUILD_GCC" \
  --enable-static \
  --disable-shared \
  CFLAGS="$CFLAGS -std=c99"
make $MAKEFLAGS
make install
popd

rm -rf ${BASH_SOURCE[0]} nettle*
