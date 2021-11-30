#!/bin/bash

. set-env-android.sh
####################################################################################################

cd "$NDK_ADDON_SRC"
apt-get source libgcrypt20

pushd libgcrypt20*/
#autoreconf -fi
./configure \
  AS="$NDK_TOOLCHAIN-clang" \
  CC="$NDK_TOOLCHAIN-clang" \
  CXX="$NDK_TOOLCHAIN-clang++" \
  AR=llvm-ar \
  RANLIB=llvm-ranlib \
  STRIP=llvm-strip \
  --prefix="$NDK_ADDON_PREFIX" \
  --host="$NDK_TARGET" \
  --build="$BUILD_ARCH" \
  --with-build-cc="$BUILD_GCC" \
  --enable-static \
  --disable-shared \
  --with-libgpg-error-prefix="$NDK_ADDON_PREFIX"

case $NDK_TOOLCHAIN in
  i686* | x86*)
    echo '#define PIC 1' >mpi/sysdep.h
    echo '#define C_SYMBOL_NAME(name) name' >>mpi/sysdep.h
    ;;
esac

make "$MAKEFLAGS"
make install
popd

rm -rf "${BASH_SOURCE[0]}" libgcrypt20*
