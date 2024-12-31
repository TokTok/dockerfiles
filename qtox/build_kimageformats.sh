#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2024 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "kimageformats" --supported "linux macos-x86_64 macos-arm64" "$@"

"$SCRIPT_DIR/download/download_kimageformats.sh"

if [ "$LIB_TYPE" = "shared" ]; then
  ENABLE_SHARED=ON
else
  ENABLE_SHARED=OFF
fi

"$QT_PREFIX/bin/qt-cmake" \
  -DCMAKE_INSTALL_PREFIX="$DEP_PREFIX" \
  -DCMAKE_BUILD_TYPE="$CMAKE_BUILD_TYPE" \
  -DBUILD_SHARED_LIBS="$ENABLE_SHARED" \
  -DCMAKE_CXX_FLAGS="-DQT_MESSAGELOGCONTEXT" \
  -DKDE_INSTALL_QTPLUGINDIR="$QT_PREFIX/plugins" \
  -B_build \
  -GNinja \
  -Wno-dev \
  .
cmake --build _build
cmake --install _build
