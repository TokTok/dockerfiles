#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2022 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

# shellcheck disable=SC2034

set -euxo pipefail

usage() {
  # note: this is the usage from the build script's context, so the usage
  # doesn't include --dep argument, since that comes from the build script
  # itself.
  echo "Download and build $DEP_NAME for the Windows cross compiling environment"
  echo "Usage: $0 --arch {$1}"
}

assert_supported() {
  read -r -a supported_array <<<"$2"
  for supported in "${supported_array[@]}"; do
    if [ "$1" == "$supported" ]; then
      return
    fi
  done
  usage "$2"
  exit 1
}

parse_arch() {
  LIB_TYPE=shared
  BUILD_TYPE=release
  SANITIZE=
  EXTRA_ARGS=()
  MACOS_MINIMUM_SUPPORTED_VERSION=12.0
  IOS_MINIMUM_SUPPORTED_VERSION=10.0

  while (($# > 0)); do
    case $1 in
      --arch)
        SCRIPT_ARCH=$2
        shift 2
        ;;
      --dep)
        DEP_NAME=$2
        shift 2
        ;;
      --libtype)
        LIB_TYPE=$2
        shift 2
        ;;
      --prefix)
        DEP_PREFIX=$2
        shift 2
        ;;
      --buildtype)
        BUILD_TYPE=$2
        shift 2
        ;;
      --macos)
        MACOS_MINIMUM_SUPPORTED_VERSION=$2
        shift 2
        ;;
      --sanitize)
        SANITIZE=$2
        shift 2
        ;;
      --supported)
        SUPPORTED=$2
        shift 2
        ;;
      -h | --help)
        usage "$SUPPORTED"
        exit 1
        ;;
      --)
        shift 1
        EXTRA_ARGS=("$@")
        break
        ;;
      *)
        echo "Unexpected argument $1"
        usage "$SUPPORTED"
        exit 1
        ;;
    esac
  done

  assert_supported "$SCRIPT_ARCH" "$SUPPORTED"
  export MACOS_MINIMUM_SUPPORTED_VERSION
  export IOS_MINIMUM_SUPPORTED_VERSION

  if [ "$SCRIPT_ARCH" == "win32" ] || [ "$SCRIPT_ARCH" == "win64" ]; then
    if [ "$SCRIPT_ARCH" == "win32" ]; then
      MINGW_ARCH="i686"
    elif [ "$SCRIPT_ARCH" == "win64" ]; then
      MINGW_ARCH="x86_64"
    fi
    DEP_PREFIX=${DEP_PREFIX:-/windows}
    HOST_OPTION="--host=$MINGW_ARCH-w64-mingw32"
    CROSS_LDFLAG=""
    CROSS_CFLAG=""
    CROSS_CPPFLAG=""
    CROSS_CXXFLAG=""
    MAKE_JOBS="$(nproc)"
    CMAKE_TOOLCHAIN_FILE="-DCMAKE_TOOLCHAIN_FILE=/build/windows-toolchain.cmake"
  elif [ "$SCRIPT_ARCH" == "macos-x86_64" ] || [ "$SCRIPT_ARCH" == "macos-arm64" ]; then
    DEP_PREFIX="${DEP_PREFIX:-/work}"
    mkdir -p "$DEP_PREFIX"
    HOST_OPTION=''
    MACOS_FLAGS="-mmacosx-version-min=$MACOS_MINIMUM_SUPPORTED_VERSION"
    CROSS_LDFLAG="$MACOS_FLAGS"
    CROSS_CFLAG="$MACOS_FLAGS"
    CROSS_CPPFLAG="$MACOS_FLAGS"
    CROSS_CXXFLAG="$MACOS_FLAGS"
    MAKE_JOBS="$(sysctl -n hw.ncpu)"
    CMAKE_TOOLCHAIN_FILE=""
  elif [ "$SCRIPT_ARCH" == "ios-arm64" ]; then
    DEP_PREFIX="${DEP_PREFIX:-/work}"
    mkdir -p "$DEP_PREFIX"
    HOST_OPTION="--host=arm64-apple-darwin"
    IOS_FLAGS="-miphoneos-version-min=$IOS_MINIMUM_SUPPORTED_VERSION -arch arm64 -isysroot $(xcrun --sdk iphoneos --show-sdk-path)"
    CROSS_LDFLAG="$IOS_FLAGS"
    CROSS_CFLAG="$IOS_FLAGS"
    CROSS_CPPFLAG="$IOS_FLAGS"
    CROSS_CXXFLAG="$IOS_FLAGS"
    MAKE_JOBS="$(sysctl -n hw.ncpu)"
    CMAKE_TOOLCHAIN_FILE=""
  elif [[ "$SCRIPT_ARCH" == "linux"* ]]; then
    DEP_PREFIX="${DEP_PREFIX:-/work}"
    mkdir -p "$DEP_PREFIX"
    HOST_OPTION=''
    CROSS_LDFLAG=""
    CROSS_CFLAG=""
    CROSS_CPPFLAG=""
    CROSS_CXXFLAG=""
    MAKE_JOBS="$(nproc)"
    CMAKE_TOOLCHAIN_FILE=""
  else
    echo "Unexpected arch $SCRIPT_ARCH"
    usage "$SUPPORTED"
    exit 1
  fi

  if [ "$BUILD_TYPE" = "release" ]; then
    CMAKE_BUILD_TYPE="Release"
  elif [ "$BUILD_TYPE" = "debug" ]; then
    CMAKE_BUILD_TYPE="RelWithDebInfo"
  else
    echo "Unexpected build type $BUILD_TYPE"
    usage "$SUPPORTED"
    exit 1
  fi

  if [ "$SANITIZE" = "asan" ]; then
    CLANG_SANITIZER="address"
  elif [ "$SANITIZE" = "tsan" ]; then
    CLANG_SANITIZER="thread"
  elif [ "$SANITIZE" = "ubsan" ]; then
    CLANG_SANITIZER="undefined"
  else
    CLANG_SANITIZER=""
  fi

  if [ "$SCRIPT_ARCH" == "win32" ] || [ "$SCRIPT_ARCH" == "win64" ]; then
    QT_PREFIX=$DEP_PREFIX
  elif [ -n "$SANITIZE" ]; then
    QT_PREFIX="$DEP_PREFIX/qt-$SANITIZE"
  else
    QT_PREFIX="$DEP_PREFIX/qt"
  fi

  export PATH="$QT_PREFIX/bin:$PATH"
  export PKG_CONFIG_PATH="$DEP_PREFIX/lib/pkgconfig:$DEP_PREFIX/lib64/pkgconfig"
}
