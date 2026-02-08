#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024-2025 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "toxcore" --supported "linux-x86_64 win32 win64 macos-x86_64 macos-arm64 wasm ios-arm64 iphonesimulator-arm64 iphonesimulator-x86_64" "$@"

if [ "$LIB_TYPE" = "shared" ]; then
  ENABLE_STATIC=OFF
  ENABLE_SHARED=ON
else
  ENABLE_STATIC=ON
  ENABLE_SHARED=OFF
fi

if [ "$SCRIPT_ARCH" = "wasm" ]; then
  MIN_LOGGER_LEVEL=TRACE
else
  MIN_LOGGER_LEVEL=DEBUG
fi

if [ -d "../../../c-toxcore" ]; then
  pushd "../../../c-toxcore" >/dev/null || exit 1
else
  TOXCORE_SRC="$(realpath .)/toxcore"

  mkdir -p "$TOXCORE_SRC"
  pushd "$TOXCORE_SRC" >/dev/null || exit 1

  "$SCRIPT_DIR/download/download_toxcore.sh"
fi

if [ -n "$SANITIZE" ]; then
  export CFLAGS="-fsanitize=$CLANG_SANITIZER"
  export CXXFLAGS="-fsanitize=$CLANG_SANITIZER"
  CMAKE_BUILD_TYPE=Debug
fi

if [[ "$SCRIPT_ARCH" == "ios-"* ]] || [[ "$SCRIPT_ARCH" == "iphonesimulator-"* ]]; then
  DEPLOYMENT_TARGET="$IOS_MINIMUM_SUPPORTED_VERSION"
else
  DEPLOYMENT_TARGET="$MACOS_MINIMUM_SUPPORTED_VERSION"
fi

"${EMCMAKE[@]}" cmake \
  -DCMAKE_INSTALL_PREFIX="$DEP_PREFIX" \
  -DBOOTSTRAP_DAEMON=OFF \
  -DEXPERIMENTAL_API=ON \
  -DMIN_LOGGER_LEVEL="$MIN_LOGGER_LEVEL" \
  -DCMAKE_BUILD_TYPE="$CMAKE_BUILD_TYPE" \
  -DENABLE_STATIC="$ENABLE_STATIC" \
  -DENABLE_SHARED="$ENABLE_SHARED" \
  "${CMAKE_TOOLCHAIN_FILE[@]}" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="$DEPLOYMENT_TARGET" \
  -GNinja \
  -B_build \
  .

cmake --build _build
cmake --install _build

popd >/dev/null
