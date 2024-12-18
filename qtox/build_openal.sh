#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
#     Copyright (c) 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
#     Copyright (c) 2021 by The qTox Project Contributors

set -euo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "openal" --supported "win32 win64 macos macos-x86_64 macos-arm64" "$@"

"$SCRIPT_DIR/download/download_openal.sh"

if [ "$SCRIPT_ARCH" != "macos" ] && [ "$SCRIPT_ARCH" != "macos-x86_64" ] && [ "$SCRIPT_ARCH" != "macos-arm64" ]; then
  patch -p1 <"$SCRIPT_DIR/patches/openal-cmake-3-11.patch"
  DSOUND_INCLUDE_DIR="/usr/$MINGW_ARCH-w64-mingw32/include"
  DSOUND_LIBRARY="/usr/$MINGW_ARCH-w64-mingw32/lib/libdsound.a"
  MACOSX_RPATH="OFF"
else
  DSOUND_INCLUDE_DIR=""
  DSOUND_LIBRARY=""
  MACOSX_RPATH="ON"
fi

if [ "$LIB_TYPE" = "shared" ]; then
  LIBTYPE=SHARED
else
  LIBTYPE=STATIC
fi

export CFLAGS="-fPIC"
cmake \
  "$CMAKE_TOOLCHAIN_FILE" \
  -DCMAKE_INSTALL_PREFIX="$DEP_PREFIX" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="$MACOS_MINIMUM_SUPPORTED_VERSION" \
  -DCMAKE_MACOSX_RPATH="$MACOSX_RPATH" \
  -DALSOFT_UTILS=OFF \
  -DALSOFT_EXAMPLES=OFF \
  -DLIBTYPE="$LIBTYPE" \
  -DDSOUND_INCLUDE_DIR="$DSOUND_INCLUDE_DIR" \
  -DDSOUND_LIBRARY="$DSOUND_LIBRARY" \
  .

make -j "$MAKE_JOBS"
make install
