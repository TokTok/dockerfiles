#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "qrencode" --supported "linux-x86_64 win32 win64 macos-x86_64 macos-arm64 wasm ios-arm64 iphonesimulator-arm64 iphonesimulator-x86_64" "$@"

if [ "$LIB_TYPE" = "shared" ]; then
  BUILD_SHARED_LIBS=ON
else
  BUILD_SHARED_LIBS=OFF
fi

"$SCRIPT_DIR/download/download_qrencode.sh"

if [[ "$SCRIPT_ARCH" == "ios-"* ]] || [[ "$SCRIPT_ARCH" == "iphonesimulator-"* ]]; then
  DEPLOYMENT_TARGET="$IOS_MINIMUM_SUPPORTED_VERSION"
else
  DEPLOYMENT_TARGET="$MACOS_MINIMUM_SUPPORTED_VERSION"
fi

"${EMCMAKE[@]}" cmake . \
  -DCMAKE_BUILD_TYPE="$CMAKE_BUILD_TYPE" \
  -DCMAKE_INSTALL_PREFIX="$DEP_PREFIX" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="$DEPLOYMENT_TARGET" \
  "${CMAKE_TOOLCHAIN_FILE[@]}" \
  -DWITH_TOOLS=OFF \
  -DBUILD_SHARED_LIBS="$BUILD_SHARED_LIBS"

make -j "$MAKE_JOBS"
make install
