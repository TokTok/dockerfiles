#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later AND MIT
# Copyright © 2017-2021 Maxim Biro <nurupo.contributions@gmail.com>
# Copyright © 2021 by The qTox Project Contributors
# Copyright © 2024 The TokTok team

set -euxo pipefail

readonly SCRIPT_DIR="$(dirname "$(realpath "$0")")"

source "$SCRIPT_DIR/build_utils.sh"

parse_arch --dep "toxcore" --supported "win32 win64 macos-x86_64 macos-arm64" "$@"

if [ "$LIB_TYPE" = "shared" ]; then
  ENABLE_STATIC=OFF
  ENABLE_SHARED=ON
else
  ENABLE_STATIC=ON
  ENABLE_SHARED=OFF
fi

build_toxcore() {
  if [ -d "../../../c-toxcore" ]; then
    pushd "../../../c-toxcore" >/dev/null || exit 1
  else
    TOXCORE_SRC="$(realpath .)/toxcore"

    mkdir -p "$TOXCORE_SRC"
    pushd "$TOXCORE_SRC" >/dev/null || exit 1

    "$SCRIPT_DIR/download/download_toxcore.sh"
  fi

  cmake -DCMAKE_INSTALL_PREFIX="$DEP_PREFIX" \
    -DBOOTSTRAP_DAEMON=OFF \
    -DMIN_LOGGER_LEVEL=DEBUG \
    -DCMAKE_BUILD_TYPE="$CMAKE_BUILD_TYPE" \
    -DENABLE_STATIC="$ENABLE_STATIC" \
    -DENABLE_SHARED="$ENABLE_SHARED" \
    "$CMAKE_TOOLCHAIN_FILE" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="$MACOS_MINIMUM_SUPPORTED_VERSION" \
    -GNinja \
    -B_build \
    .

  cmake --build _build
  cmake --install _build

  popd >/dev/null
}

build_toxcore
