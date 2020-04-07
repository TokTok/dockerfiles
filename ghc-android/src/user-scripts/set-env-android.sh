#!/bin/bash
# shellcheck disable=SC2034

#
# This script builds on the base ghc set-env.sh and adds the NDK version and
# GHC build dependencies for the Android cross compiler.
#

. set-env.sh

# Basic parameters
NDK_RELEASE=${NDK_RELEASE:-r12b}
NDK_MD5=1d1a5ee71a5123be01e0dd9adb5df80d
NDK_PLATFORM=${NDK_PLATFORM:-android-14}
NDK_TOOLCHAIN=${NDK_TOOLCHAIN:-arm-linux-androideabi-4.9}

NDK_DESC=$NDK_PLATFORM-$NDK_TOOLCHAIN
NDK="$GHCHOME/$NDK_PLATFORM/$NDK_TOOLCHAIN"
NDK_ADDON_SRC="$BASEDIR/build-$NDK_DESC"
NDK_ADDON_PREFIX="$NDK/sysroot/usr"

GHC_PREFIX="$NDK"
GHC_SRC="$NDK_ADDON_SRC/ghc"

NCURSES_RELEASE=6.0
NCURSES_MD5=ee13d052e1ead260d7c28071f46eefb1

GMP_RELEASE=6.1.1
GMP_MD5=e70e183609244a332d80529e7e155a35

mkdir -p "$NDK_ADDON_SRC"

# Add toolchain to path
export PATH="$NDK/bin":$PATH

# Download and configure the Android NDK toolchain
NDK_PATH="$HOME/android-ndk-$NDK_RELEASE"

# Unpack ncurses
NCURSES_TAR_FILE=ncurses-${NCURSES_RELEASE}.tar.gz
NCURSES_TAR_PATH="${TARDIR}/${NCURSES_TAR_FILE}"
NCURSES_SRC="$NDK_ADDON_SRC/ncurses-${NCURSES_RELEASE}"

ICONV_SRC="$NDK_ADDON_SRC/iconv"
# Last known working git commit
ICONV_GIT_COMMIT=d5006db0ff4449b447946ab31d1a41b63078c773

GMP_TAR_FILE=gmp-${GMP_RELEASE}.tar.xz
GMP_TAR_PATH="${TARDIR}/${GMP_TAR_FILE}"
GMP_SRC="$NDK_ADDON_SRC/gmp-${GMP_RELEASE}"
