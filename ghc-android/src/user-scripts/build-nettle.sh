#!/bin/bash

. set-env.sh
####################################################################################################

cd $NDK_ADDON_SRC
apt-get source nettle

pushd nettle*
sed -i -e 's/__gmpz_mpz_powm/__gmpz_powm/' configure.ac
autoreconf -fi
./configure --prefix="$NDK_ADDON_PREFIX" --host=$NDK_TARGET --build=$BUILD_ARCH --with-build-cc=$BUILD_GCC --enable-static --disable-shared
make $MAKEFLAGS
make install
popd

rm -rf ${BASH_SOURCE[0]} nettle*
