#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "openal" --supported "linux-x86_64 win32 win64 macos-x86_64 macos-arm64 wasm ios-arm64 iphonesimulator-arm64 iphonesimulator-x86_64" "$@"

"$SCRIPT_DIR/download/download_openal.sh"

if [ "$LIB_TYPE" = "shared" ]; then
  LIBTYPE=SHARED
else
  LIBTYPE=STATIC
fi

if [[ "$SCRIPT_ARCH" == "ios-"* ]] || [[ "$SCRIPT_ARCH" == "iphonesimulator-"* ]]; then
  DEPLOYMENT_TARGET="$IOS_MINIMUM_SUPPORTED_VERSION"
else
  DEPLOYMENT_TARGET="$MACOS_MINIMUM_SUPPORTED_VERSION"
fi

export CFLAGS="-fPIC"
export CXXFLAGS="-fPIC -std=c++20"
"${EMCMAKE[@]}" cmake \
  "${CMAKE_TOOLCHAIN_FILE[@]}" \
  -DCMAKE_INSTALL_PREFIX="$DEP_PREFIX" \
  -DCMAKE_BUILD_TYPE="$CMAKE_BUILD_TYPE" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="$DEPLOYMENT_TARGET" \
  -DCMAKE_MACOSX_RPATH=ON \
  -DALSOFT_UTILS=OFF \
  -DALSOFT_EXAMPLES=OFF \
  -DALSOFT_ENABLE_MODULES=OFF \
  -DCMAKE_CXX_SCAN_FOR_MODULES=OFF \
  -DHAVE_WFUNCTION_EFFECTS=OFF \
  -DLIBTYPE="$LIBTYPE" \
  -GNinja \
  -B_build \
  .

cmake --build _build
cmake --install _build
