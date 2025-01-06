#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "zstd" --supported "win32 win64 macos-x86_64 macos-arm64" "$@"

if [ "$LIB_TYPE" = "shared" ]; then
  ENABLE_STATIC=OFF
  ENABLE_SHARED=ON
else
  ENABLE_STATIC=ON
  ENABLE_SHARED=OFF
fi

"$SCRIPT_DIR/download/download_zstd.sh"

cmake -DCMAKE_INSTALL_PREFIX="$DEP_PREFIX" \
  -DCMAKE_BUILD_TYPE="$CMAKE_BUILD_TYPE" \
  -DZSTD_BUILD_STATIC="$ENABLE_STATIC" \
  -DZSTD_BUILD_SHARED="$ENABLE_SHARED" \
  -DBUILD_SHARED_LIBS="$ENABLE_SHARED" \
  -DZSTD_BUILD_PROGRAMS=OFF \
  "$CMAKE_TOOLCHAIN_FILE" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="$MACOS_MINIMUM_SUPPORTED_VERSION" \
  -GNinja \
  -B_build \
  build/cmake

cmake --build _build
cmake --install _build
