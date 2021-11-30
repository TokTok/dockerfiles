#!/bin/bash

. set-env.sh
####################################################################################################

NDK_RELEASE=r23b

NDK_TAR_FILE="android-ndk-$NDK_RELEASE-linux.zip"
NDK_TAR_PATH="$TARDIR/$NDK_TAR_FILE"

echo Unpacking the Android NDK "$NDK_RELEASE"
./unpack-ndk.pl "$NDK_RELEASE" "$NDK_TAR_PATH" "$NDK_TOOLCHAIN"
rm "$NDK_TAR_PATH"

TOOLCHAIN="$HOME/android-ndk-$NDK_RELEASE/toolchains/llvm/prebuilt/linux-x86_64"

ln "$TOOLCHAIN/bin/$NDK_TOOLCHAIN$NDK_API-clang"   "$TOOLCHAIN/bin/$NDK_TOOLCHAIN-clang"
ln "$TOOLCHAIN/bin/$NDK_TOOLCHAIN$NDK_API-clang++" "$TOOLCHAIN/bin/$NDK_TOOLCHAIN-clang++"

ln "$TOOLCHAIN/bin/llvm-ar"     "$TOOLCHAIN/bin/$NDK_TOOLCHAIN-ar"
ln "$TOOLCHAIN/bin/llvm-nm"     "$TOOLCHAIN/bin/$NDK_TOOLCHAIN-nm"
ln "$TOOLCHAIN/bin/llvm-ranlib" "$TOOLCHAIN/bin/$NDK_TOOLCHAIN-ranlib"
ln "$TOOLCHAIN/bin/llvm-strip"  "$TOOLCHAIN/bin/$NDK_TOOLCHAIN-strip"
ln "$TOOLCHAIN/bin/ld"          "$TOOLCHAIN/bin/$NDK_TOOLCHAIN-ld"

rm -f "${BASH_SOURCE[0]}"
