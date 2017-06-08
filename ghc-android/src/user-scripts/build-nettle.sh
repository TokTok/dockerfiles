#!/bin/bash

set -x

. set-env.sh
####################################################################################################

cd $NDK_ADDON_SRC

echo "################################"
cat /etc/apt/sources.list
echo "################################"
ls -al /etc/apt/sources.list.d
echo "################################"


# HACK
# echo 'deb-src http://security.ubuntu.com/ubuntu/ xenial-security main restricted' >> /etc/apt/sources.list
# echo 'deb-src http://security.ubuntu.com/ubuntu/ xenial-security multiverse' >> /etc/apt/sources.list
# sudo apt-get update
# HACK

# apt-get source nettle
curl 'https://ftp.gnu.org/gnu/nettle/nettle-3.3.tar.gz' --output nettlXe.tar.gz
tar -xzvf nettlXe.tar.gz

pushd nettle*
sed -i -e 's/__gmpz_mpz_powm/__gmpz_powm/' configure.ac
autoreconf -fi
./configure --prefix="$NDK_ADDON_PREFIX" --host=$NDK_TARGET --build=$BUILD_ARCH --with-build-cc=$BUILD_GCC --enable-static --disable-shared
make $MAKEFLAGS
make install
popd

rm -rf ${BASH_SOURCE[0]} nettle*
